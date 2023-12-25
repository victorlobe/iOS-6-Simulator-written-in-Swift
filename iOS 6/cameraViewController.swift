//
//  cameraViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 27.07.2017.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import OrientationTracker

@available(iOS 11.1, *)
class cameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, CLLocationManagerDelegate {
    @IBOutlet var previewView: UIView!
    @IBOutlet var modeSwitcherControl: UISlider!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var cameraButtonInnerImage: UIImageView!
    @IBOutlet var recentButton: UIButton!
    @IBOutlet var focusImageViewOut: UIImageView!
    @IBOutlet var cameraLens: UIImageView!
    @IBOutlet var rotateObjects: [UIView]!

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var currentMode = 0
    var currentSide = 0
    var videoDeviceInput: AVCaptureDeviceInput!
    var currentImage = UIImage()
    var shutterAnimation = CATransition()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    @IBAction func modeSwitch(_ sender: Any) {
        switch currentMode {
        case 0:
            switchToVideo()
        case 1:
            switchToPhoto()
        default:
            break
        }
    }
    
    @available(iOS 13.0, *)
    @IBAction func switchCamera(_ sender: Any) {
        switch currentSide {
        case 0:
            intializeFrontCamera()
            currentSide = 1
        case 1:
            intializeBackCamera()
            currentSide = 0
        default:
            break
        }
        DispatchQueue.main.async {
            let transition = CATransition()
            transition.type = "oglFlip"
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.4
            self.previewView.layer.add(transition, forKey: "transition")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recentButton.roundCorners(corners: .allCorners, radius: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSwitcherControl.setThumbImage(UIImage(named: "PLCameraSwitchHandle"), for: .normal)
        modeSwitcherControl.setValue(0, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrientation), name: OrientationTracker.deviceOrientationChangedNotification, object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
        locationManager.requestWhenInUseAuthorization()
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("Photos authorzed")
                } else {}
            })
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        else{
            print("Location Services denied by user")
        }
        intializeBackCamera()
    }
    
    @objc func updateOrientation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4) {
                for object in self.rotateObjects {
                    object.transform = OrientationTracker.shared.affineTransform
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    func startSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
    }
    
    func intializeBackCamera() {
        self.captureSession.stopRunning()
        startSession()
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(videoDeviceInput) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(videoDeviceInput)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        autofocus()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(autofocus),
                                               name: .AVCaptureDeviceSubjectAreaDidChange,
                                               object: videoDeviceInput.device)
    }
    
    @available(iOS 13.0, *)
    func intializeFrontCamera() {
        self.captureSession.stopRunning()
        startSession()
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            else {
                print("Unable to access front camera!")
                return
        }
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(videoDeviceInput) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(videoDeviceInput)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        autofocus()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(autofocus),
                                               name: .AVCaptureDeviceSubjectAreaDidChange,
                                               object: videoDeviceInput.device)
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                    self.videoPreviewLayer.frame = self.previewView.bounds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.cameraLens.isHidden = true
                }
            }
        }
    }
    @IBAction func cameraButtonTouchDown(_ sender: Any) {
        cameraButton.setBackgroundImage(UIImage(named: "PLCameraLargeShutterButtonPressed_2only_-568h"), for: .normal)
        
    }
    
    @IBAction func cameraButtonRelease(_ sender: Any) {
        cameraButton.setBackgroundImage(UIImage(named: "PLCameraLargeShutterButton_2only_-568h"), for: .normal)
        cameraLens.isHidden = false
        
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        
    }
    @IBAction func cameraButtonTouchCancelled(_ sender: Any) {
        cameraButton.setBackgroundImage(UIImage(named: "PLCameraLargeShutterButton_2only_-568h"), for: .normal)
    }
    
    var currentlyFocusing = false
    
    @IBAction func focusAndExposeTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if currentlyFocusing == true {} else {
            currentlyFocusing = true
            let devicePoint = videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: gestureRecognizer.location(in: gestureRecognizer.view))
            focus(with: .autoFocus, exposureMode: .autoExpose, at: devicePoint, monitorSubjectAreaChange: true)
            focusImageViewOut.frame.origin = gestureRecognizer.location(in: gestureRecognizer.view)
            focusImageViewOut.frame.origin.x = focusImageViewOut.frame.origin.x-focusImageViewOut.frame.width/2
            focusImageViewOut.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            focusImageViewOut.isHidden = false
            focusImageViewOut.image = UIImage(named: "PLFocusCrosshairsSmall0")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairsSmall1")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairsSmall0")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairsSmall1")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairsSmall0")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.focusImageViewOut.isHidden = true
                self.currentlyFocusing = false
            }
        }
    }
    
    @objc func autofocus() {
        let devicePoint = CGPoint(x: 0.5, y: 0.5)
        focus(with: .continuousAutoFocus, exposureMode: .continuousAutoExposure, at: devicePoint, monitorSubjectAreaChange: false)
        focusImageViewOut.frame.origin = CGPoint(x: previewView.frame.midX-focusImageViewOut.frame.width/2, y: previewView.frame.midY-focusImageViewOut.frame.height/2)
        focusImageViewOut.transform = CGAffineTransform(scaleX: 1, y: 1)
        focusImageViewOut.isHidden = false
        focusImageViewOut.image = UIImage(named: "PLFocusCrosshairs0")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairs1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairs0")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairs1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.focusImageViewOut.image = UIImage(named: "PLFocusCrosshairs0")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.focusImageViewOut.isHidden = true
        }
    }
    
    private func focus(with focusMode: AVCaptureDevice.FocusMode,
                       exposureMode: AVCaptureDevice.ExposureMode,
                       at devicePoint: CGPoint,
                       monitorSubjectAreaChange: Bool) {
        
        sessionQueue.async {
            let device = self.videoDeviceInput.device
            do {
                try device.lockForConfiguration()
                
                /*
                 Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                 Call set(Focus/Exposure)Mode() to apply the new point of interest.
                 */
                if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                    device.focusPointOfInterest = devicePoint
                    device.focusMode = focusMode
                }
                
                if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                    device.exposurePointOfInterest = devicePoint
                    device.exposureMode = exposureMode
                }
                
                device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                device.unlockForConfiguration()
            } catch {
                print("Could not lock device for configuration: \(error)")
            }
        }
    }
    
    func switchToPhoto() {
        currentMode = 0
        modeSwitcherControl.setValue(0, animated: true)
        cameraButtonInnerImage.image = UIImage(named: "PLCameraLargeShutterButtonPhoto_2only_-568h")
        
    }
    
    func switchToVideo() {
        currentMode = 1
        modeSwitcherControl.setValue(1, animated: true)
        cameraButtonInnerImage.image = UIImage(named: "PLCameraButtonRecordOff")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let photoWithMetadata = getFileRepresentationWithLocationData(photo: photo)
        currentImage = UIImage(data: photoWithMetadata) ?? UIImage()
        UIImageWriteToSavedPhotosAlbum(currentImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            print("Error")
            
        } else {
            //Saved
            recentButton.setImage(currentImage, for: .normal)
            recentButton.setBackgroundImage(UIImage(named: "PLCameraPreviewWell_2only_-568h"), for: .normal)
            //Open Lens
            cameraLens.isHidden = true
        }
    }
    
    func addAsset(image: UIImage, location: CLLocation? = nil) {
        PHPhotoLibrary.shared().performChanges({
            // Request creating an asset from the image.
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            // Set metadata location
            if let location = location {
                creationRequest.location = location
            }
            
        }, completionHandler: { success, error in
            if !success { NSLog("error creating asset: \(error)") }
        })
    }
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
    }
    // create GPS metadata properties
    func createLocationMetadata() -> NSMutableDictionary? {

        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {return nil}

        if let location = locationManager.location {
            let gpsDictionary = NSMutableDictionary()
            var latitude = location.coordinate.latitude
            var longitude = location.coordinate.longitude
            var altitude = location.altitude
            var latitudeRef = "N"
            var longitudeRef = "E"
            var altitudeRef = 0

            if latitude < 0.0 {
                latitude = -latitude
                latitudeRef = "S"
            }

            if longitude < 0.0 {
                longitude = -longitude
                longitudeRef = "W"
            }

            if altitude < 0.0 {
                altitude = -altitude
                altitudeRef = 1
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy:MM:dd"
            gpsDictionary[kCGImagePropertyGPSDateStamp] = formatter.string(from:location.timestamp)
            formatter.dateFormat = "HH:mm:ss"
            gpsDictionary[kCGImagePropertyGPSTimeStamp] = formatter.string(from:location.timestamp)
            gpsDictionary[kCGImagePropertyGPSLatitudeRef] = latitudeRef
            gpsDictionary[kCGImagePropertyGPSLatitude] = latitude
            gpsDictionary[kCGImagePropertyGPSLongitudeRef] = longitudeRef
            gpsDictionary[kCGImagePropertyGPSLongitude] = longitude
            gpsDictionary[kCGImagePropertyGPSDOP] = location.horizontalAccuracy
            gpsDictionary[kCGImagePropertyGPSAltitudeRef] = altitudeRef
            gpsDictionary[kCGImagePropertyGPSAltitude] = altitude

            if let heading = locationManager.heading {
                gpsDictionary[kCGImagePropertyGPSImgDirectionRef] = "T"
                gpsDictionary[kCGImagePropertyGPSImgDirection] = heading.trueHeading
            }

            return gpsDictionary;
        }
        return nil
    }
    func getFileRepresentationWithLocationData(photo : AVCapturePhoto) -> Data {
        // get image metadata
        var properties = photo.metadata

        // add gps data to metadata
        if let gpsDictionary = createLocationMetadata() {
            properties[kCGImagePropertyGPSDictionary as String] = gpsDictionary
        }

        // create new file representation with edited metadata
        return photo.fileDataRepresentation(withReplacementMetadata:properties,
            replacementEmbeddedThumbnailPhotoFormat:photo.embeddedThumbnailPhotoFormat,
            replacementEmbeddedThumbnailPixelBuffer:photo.previewPixelBuffer,
            replacementDepthData:photo.depthData)!
    }
}
