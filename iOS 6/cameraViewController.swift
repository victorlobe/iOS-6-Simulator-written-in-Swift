//
//  cameraViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 27.07.2017.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation

class cameraViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var photoTimer: Timer!
    
    var image: UIImage?
    
    @IBOutlet var camLens: UIImageView!
    @IBOutlet var camOptionsRotated: UIButton!
    @IBOutlet var camOptions: UIButton!
    @IBOutlet var cameraButtonOutlet: UIButton!
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func cameraButton(_ sender: Any) {
        
        
        
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        
        camLens.isHidden = false
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(lensEffect), userInfo: nil, repeats: false)
        
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIImageWriteToSavedPhotosAlbum(self.image!, nil, nil, nil)
            print("photo saved to camera roll")

        }
        
    }
    
    @IBAction func camOptionsAction(_ sender: Any) {
        
        

    }
    
    
    @IBAction func photoPreview(_ sender: Any) {
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        StartRunningCaptureSession()
        photoTimer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.camLens.isHidden = true
            
        }
        
        
        print("camera loaded")
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession?.devices
        for device in devices! {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
            
            
        }
        
        currentCamera = backCamera
        
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
            
            
        }    }
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        
    }
    func StartRunningCaptureSession() {
        captureSession.startRunning()
        
        
    }
    
    func lensEffect() {
        
        camLens.isHidden = true
        
    }
    
    func runTimedCode() {
        
        photo.image = image
        
        
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func rotated() {
        if UIDevice.current.orientation.isLandscape{
            cameraButtonOutlet.setImage( UIImage.init(named: "camCamButtonRotated"), for: .normal)
            camOptions.isHidden = true
            camOptionsRotated.isHidden = false
            
            print("Landscape")
        } else {
            cameraButtonOutlet.setImage( UIImage.init(named: "camCamButton"), for: .normal)
            camOptions.isHidden = false
            camOptionsRotated.isHidden = true
            print("Portrait")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue" {
            let previewVC = segue.destination as! camPreviewViewController
            previewVC.image = self.image
        }
    }
    
}

extension cameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutpute(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "previewSegue", sender: nil)
        }
    }
}
