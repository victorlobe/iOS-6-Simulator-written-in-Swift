//
//  lockscreenViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 07.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation
import CoreTelephony
import Reachability
import MediaPlayer
import Postal
import AudioToolbox

@available(iOS 13.5, *)
class lockscreenViewController: UIViewController {
    let reachability = Reachability()!
    
    
    var player: AVAudioPlayer = AVAudioPlayer()
    let playerSession = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet var lsBar: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var wallpaper: UIImageView!
    @IBOutlet var lsBattery: UIImageView!
    @IBOutlet var cautionImg: UIImageView!
    @IBOutlet var mediaControlView: UIView!
    @IBOutlet var MCartistLabel: UILabel!
    @IBOutlet var MCTitleLabel: UILabel!
    @IBOutlet var MCAlbumLabel: UILabel!
    @IBOutlet var MCVolSliderOut: UISlider!
    @IBOutlet var MCCoverImageView: UIImageView!
    @IBOutlet var unlockSliderOut: UISlider!
    @IBOutlet var entsperrenLabel: UILabel!
    @IBOutlet var statusbarView: UIView!
    @IBOutlet var unlockBar: UIImageView!
    @IBOutlet var cameraButtonImage: UIImageView!
    @IBOutlet var airPlayBtnOut: UIImageView!
    @IBOutlet var pushView: UIView!
    @IBOutlet var pushHeadline: UILabel!
    @IBOutlet var pushSubtext: UILabel!
    @IBOutlet var pushText: UILabel!
    @IBOutlet var pushAppIcon: UIImageView!
    @IBOutlet var homeBarView: UIView!
    @IBOutlet var cameraGrabberSliderOut: UISlider!
    @IBOutlet var cameraGrabberMoveUpOutlets: [UIView]!
    @IBOutlet var MCMirrorCoverImageView: UIImageView!
    @IBOutlet var batteryMirrorImageView: UIImageView!
    @IBOutlet var batteryMirrorReflection: UIImageView!
    @IBOutlet var MCMirrorCoverMask: UIImageView!
    
    private let wrapperLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    var dateLabelContent = "date"
    let codeTopView = UIImageView()
    let codeFieldA = UILabel()
    let codeFieldB = UILabel()
    let codeFieldC = UILabel()
    let codeFieldD = UILabel()
    let codePadImageView = UIImageView()
    let codePadBtnA = UIButton()
    let codePadBtnB = UIButton()
    let codePadBtnC = UIButton()
    let codePadBtnD = UIButton()
    let codePadBtnE = UIButton()
    let codePadBtnF = UIButton()
    let codePadBtnG = UIButton()
    let codePadBtnH = UIButton()
    let codePadBtnI = UIButton()
    let codePadBtnJ = UIButton()
    let codePadBtnEmergency = UIButton()
    let codePadBtnCancel = UIButton()
    var codeInput = ""
    var code = UserDefaults.standard.string(forKey: "passcode")
    var deactivateInt = 0
    let pulseAnimation = CABasicAnimation(keyPath: "opacity")
    var codeMode = false
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    var autoLockMode = false
    
    
    var gradientColors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = gradientColors.map({ $0.cgColor })
        }
    }
    
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
    }
    
    
    var MyBattery: Float = 0.0
    var dateTimer = Timer()
    var mediaTimer = Timer()
    var mailTimer = Timer()
    var batteryTimer = Timer()
    var autoLockTimer = Timer()
    let emptyString = String() // Do nothing
    var batteryState = UIDevice.current.batteryState
    var homeButtonTaps = 0
    var screenOffCurtain = UIView()
    var screenOffTapGesture = UITapGestureRecognizer()
    var screenTapRecognizer = UITapGestureRecognizer()
    
    @IBOutlet var playPauseOut: UIButton!
    @IBOutlet var lastOut: UIButton!
    @IBOutlet var nextOut: UIButton!
    @IBOutlet var previousImage: UIImageView!
    @IBOutlet var nextImage: UIImageView!
    @IBOutlet var playPauseImage: UIImageView!
    
    
    @objc func homeButtonHandler(gesture: UITapGestureRecognizer) {
        // handle touch down and touch up events separately
        if gesture.state == .began {
            print("Home Button pressed")
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } else if gesture.state == .ended {
            print("Home Button released")
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            homeButtonTaps += 1
            let timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] timer in
                self?.homeButtonTaps = 0
            }
            switch self.homeButtonTaps {
            case 1:
                self.view.isHidden = false
            case 2:
                self.switchMCView()
                timer.invalidate()
                self.homeButtonTaps = 0
                
            default: break
            }
        }
    }
    
    
    func switchMCView() {
        if codeMode == true {} else {
            if mediaControlView.isHidden == true {
                mediaControlView.isHidden = false
                lsBar.isHidden = true
                dateLabel.isHidden = true
            } else {
                mediaControlView.isHidden = true
                lsBar.isHidden = false
                dateLabel.isHidden = false
            }
        }
    }
    
    
    @IBAction func playPause(_ sender: Any) {
        if playerSession.playbackState == .playing {
            playerSession.pause()
            playPauseImage.image = UIImage(named: "play")
            
        } else {
            playerSession.play()
            playPauseImage.image = UIImage(named: "pause")
            
        }
    }
    
    @IBAction func last(_ sender: Any) {
        playerSession.skipToPreviousItem()
    }
    
    @IBAction func next(_ sender: Any) {
        playerSession.skipToNextItem()
    }
    
    @IBAction func airPlayButton(_ sender: Any) {
        let rect = CGRect(x: -100, y: 0, width: 0, height: 0)
        let airplayVolume = MPVolumeView(frame: rect)
        airplayVolume.showsVolumeSlider = false
        self.view.addSubview(airplayVolume)
        for view: UIView in airplayVolume.subviews {
            if let button = view as? UIButton {
                button.sendActions(for: .touchUpInside)
                break
            }
        }
        airplayVolume.removeFromSuperview()
    }
    
    @IBAction func volumeSlider(_ sender: Any) {
        let volumeSlider = (MPVolumeView().subviews.filter { NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as! UISlider)
        volumeSlider.setValue((sender as AnyObject).value, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.unlockSliderOut.setThumbImage(UIImage(named: "unlockthumb"), for: UIControlState.normal)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
        
        lsBattery.isHidden = true
        
        let homeButtonPrssedGesture = UILongPressGestureRecognizer(target: self, action: #selector(homeButtonHandler))
        homeButtonPrssedGesture.minimumPressDuration = 0
        homeBarView.addGestureRecognizer(homeButtonPrssedGesture)
        
        
        self.updateBatteryState()
        
        updateTimer()
        getCurrentMetadata()
        checkMails()
        dateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        mediaTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(getCurrentMetadata), userInfo: nil, repeats: true)
        
        mailTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkMails), userInfo: nil, repeats: true)
        
        
        batteryTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchBattery), userInfo: nil, repeats: true)
        
        let batteryLevel = UIDevice.current.batteryLevel*100
        
        MyBattery = batteryLevel
        
        switchBattery()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lockscreenViewController.batteryStateDidChange),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange,
                                               object: nil)
        
        entsperrenLabel.startShimmering()
        pushView.isHidden = true
        
        cameraGrabberSliderOut.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        
        screenOffCurtain = UIView(frame: view.frame)
        screenOffCurtain.backgroundColor = UIColor.black
        screenOffCurtain.isHidden = true
        screenOffTapGesture = UITapGestureRecognizer(target: self, action: #selector(screenOn))
        screenOffTapGesture.numberOfTapsRequired = 1
        screenOffTapGesture.numberOfTouchesRequired = 1
        screenOffCurtain.addGestureRecognizer(screenOffTapGesture)
        view.addSubview(screenOffCurtain)
        
        
        mediaControlView.isHidden = true
        configureUI()
        
        codeTopView.image = UIImage(named: "password")
        codeTopView.contentMode = .scaleToFill
        codeTopView.frame = CGRect(x: -375, y: 669, width: 375, height: 109)
        
        codeFieldA.text = "•"
        codeFieldA.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        codeFieldA.textAlignment = .center
        codeFieldA.isHidden = true
        codeFieldA.frame = CGRect(x: -353, y: 692, width: 68, height: 56)
        
        codeFieldB.text = "•"
        codeFieldB.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        codeFieldB.textAlignment = .center
        codeFieldB.isHidden = true
        codeFieldB.frame = CGRect(x: -266, y: 692, width: 68, height: 56)
        
        codeFieldC.text = "•"
        codeFieldC.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        codeFieldC.textAlignment = .center
        codeFieldC.isHidden = true
        codeFieldC.frame = CGRect(x: -179, y: 692, width: 68, height: 56)
        
        codeFieldD.text = "•"
        codeFieldD.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        codeFieldD.textAlignment = .center
        codeFieldD.isHidden = true
        codeFieldD.frame = CGRect(x: -92, y: 692, width: 68, height: 56)
        
        codePadImageView.image = UIImage(named: "lsCodepad")
        codePadImageView.contentMode = .scaleToFill
        codePadImageView.frame = CGRect(x: 0, y: 812, width: 375, height: 251)
        
        codePadBtnA.frame = CGRect(x: 0, y: 812, width: 126, height: 65)
        codePadBtnA.tag = 1
        codePadBtnA.showsTouchWhenHighlighted = true
        
        codePadBtnB.frame = CGRect(x: 124, y: 812, width: 126, height: 65)
        codePadBtnB.tag = 2
        codePadBtnB.showsTouchWhenHighlighted = true
        
        codePadBtnC.frame = CGRect(x: 248, y: 812, width: 126, height: 65)
        codePadBtnC.tag = 3
        codePadBtnC.showsTouchWhenHighlighted = true
        
        codePadBtnD.frame = CGRect(x: 0, y: 877, width: 126, height: 65)
        codePadBtnD.tag = 4
        codePadBtnD.showsTouchWhenHighlighted = true
        
        codePadBtnE.frame = CGRect(x: 124, y: 877, width: 126, height: 65)
        codePadBtnE.tag = 5
        codePadBtnE.showsTouchWhenHighlighted = true
        
        codePadBtnF.frame = CGRect(x: 248, y: 877, width: 126, height: 65)
        codePadBtnF.tag = 6
        codePadBtnF.showsTouchWhenHighlighted = true
        
        codePadBtnG.frame = CGRect(x: 0, y: 942, width: 126, height: 65)
        codePadBtnG.tag = 7
        codePadBtnG.showsTouchWhenHighlighted = true
        
        codePadBtnH.frame = CGRect(x: 124, y: 942, width: 126, height: 65)
        codePadBtnH.tag = 8
        codePadBtnH.showsTouchWhenHighlighted = true
        
        codePadBtnI.frame = CGRect(x: 248, y: 942, width: 126, height: 65)
        codePadBtnI.tag = 9
        codePadBtnI.showsTouchWhenHighlighted = true
        
        codePadBtnEmergency.frame = CGRect(x: 0, y: 1007, width: 126, height: 65)
        codePadBtnEmergency.tag = 10
        codePadBtnEmergency.showsTouchWhenHighlighted = true
        codePadBtnEmergency.setTitle("Notruf", for: .normal)
        codePadBtnEmergency.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        
        codePadBtnJ.frame = CGRect(x: 124, y: 1007, width: 126, height: 65)
        codePadBtnJ.tag = 0
        codePadBtnJ.showsTouchWhenHighlighted = true
        
        codePadBtnCancel.frame = CGRect(x: 248, y: 1007, width: 126, height: 65)
        codePadBtnCancel.tag = 12
        codePadBtnCancel.showsTouchWhenHighlighted = true
        codePadBtnCancel.imageView?.contentMode = .scaleAspectFit
        codePadBtnCancel.setTitle("", for: .normal)
        codePadBtnCancel.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        
        codePadBtnA.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnB.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnC.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnD.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnE.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnF.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnG.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnH.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnI.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnJ.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnEmergency.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        codePadBtnCancel.addTarget(self, action: #selector(codeBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(codeTopView)
        view.addSubview(codeFieldA)
        view.addSubview(codeFieldB)
        view.addSubview(codeFieldC)
        view.addSubview(codeFieldD)
        view.addSubview(codePadImageView)
        view.addSubview(codePadBtnA)
        view.addSubview(codePadBtnB)
        view.addSubview(codePadBtnC)
        view.addSubview(codePadBtnD)
        view.addSubview(codePadBtnE)
        view.addSubview(codePadBtnF)
        view.addSubview(codePadBtnG)
        view.addSubview(codePadBtnH)
        view.addSubview(codePadBtnI)
        view.addSubview(codePadBtnJ)
        view.addSubview(codePadBtnEmergency)
        view.addSubview(codePadBtnCancel)
        
        let volumeView = MPVolumeView()
        volumeView.frame = CGRect(x: 14, y: 136, width: 347, height: 30)
        volumeView.showsRouteButton = false
        let temp = volumeView.subviews
        for current in temp {
            if current.isKind(of: UISlider.self) {
                let tempSlider = current as! UISlider
                tempSlider.setMinimumTrackImage(UIImage(named: "sliderTrackFilledTexture"), for: UIControlState.normal)
                tempSlider.setMaximumTrackImage(UIImage(named: "sliderTrackUnfilledTexture"), for: UIControlState.normal)
                tempSlider.setThumbImage(UIImage(named: "VolumeKnob"), for: UIControlState.normal)
            }
        }
        mediaControlView.addSubview(volumeView)
        
        let hiddenVolumeView = MPVolumeView()
        hiddenVolumeView.showsRouteButton = false
        hiddenVolumeView.showsVolumeSlider = true
        hiddenVolumeView.alpha = 0.000001
        hiddenVolumeView.isUserInteractionEnabled = false
        hiddenVolumeView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(hiddenVolumeView)
        
        ////
        
    }
    @IBAction func screenOff(_ sender: Any) {
        
        screenOffCurtain.isHidden = false
        autoLockMode = true
        autoLockTimer.invalidate()
        mediaControlView.isHidden = true
        lsBar.isHidden = false
        dateLabel.isHidden = false
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .darkContent
        } else {
            // Fallback on earlier versions
        }
        setNeedsStatusBarAppearanceUpdate()
        
        do {
            let audioPath = Bundle.main.path(forResource: "iphone_lock_screen", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //ERROR
        }
        player.play()
    }
    
    @objc func screenOn() {
        print("screen on")
        screenOffCurtain.isHidden = true
        autoLockTimer.invalidate()
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .default
        } else {
            // Fallback on earlier versions
        }
        setNeedsStatusBarAppearanceUpdate()
        
        if autoLockMode == true {
            autoLockTimer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(screenOff(_:)), userInfo: nil, repeats: false)
        }
    }
    
    @objc func checkMails() {
            let postal = Postal(configuration: .icloud(login: iCloudUsername, password: iCloudPassword))
            postal.connect { result in
                switch result {
                case .success:
                    print("[EMAIL_BACKGROUND_SERVICE]: Login succeded!")
                case .failure(let error):
                    print("[EMAIL_BACKGROUND_SERVICE]: Login failed: \(error)")
                }
            }
            
            postal.fetchLast("INBOX", last: 1, flags: [ .fullHeaders, .body ], onMessage: { email in
                print("Found Mail!")
                if "\(email.header?.from[0].email) \(email.header?.subject)" == UserDefaults.standard.string(forKey: "lastMail") {} else {
                    self.pushHeadline.text = email.header?.from[0].displayName
                    self.pushSubtext.text = email.header!.subject
                    self.pushText.text = "\(self.bodyText(body: email.body!) ?? "Diese E-Mail kann nicht angezeigt werden")"
                    if self.pushSubtext.text == "" {
                        self.pushSubtext.text = "Kein Betreff"
                    }
                    if self.pushText.text == "" {
                        self.pushText.text = "Diese E-Mail hat keinen Inhalt"
                    }
                    
                    if self.pushHeadline.text == "" {
                        self.pushHeadline.text = email.header?.from[0].email
                    }
                    self.pushView.isHidden = false
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    if let asset = NSDataAsset(name:"new-mail"){
                        do {
                            self.player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                            self.player.play()
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                    
                    if self.screenOffCurtain.isHidden == false {
                        self.screenOn()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                            self.screenOffCurtain.isHidden = false
                            if #available(iOS 13.0, *) {
                                UIApplication.shared.statusBarStyle = .darkContent
                            } else {
                                // Fallback on earlier versions
                            }
                            self.setNeedsStatusBarAppearanceUpdate()
                        }
                    }
                    
                    UserDefaults.standard.set("\(email.header?.from[0].email) \(email.header?.subject)", forKey: "lastMail")
                    self.entsperrenLabel.text = "Lesen"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        self.pushAppIcon.layer.removeAllAnimations()
                        self.pushAppIcon.layer.opacity = 1
                        self.entsperrenLabel.text = "Entsperren"
                    }
                }
            }, onComplete: { error in
                print("[EMAIL_BACKGROUND_SERVICE]: Error fetching new messages: \(error)")})
            
    }
    
    func bodyText(body: MailPart) -> String? {
        for part in body.allParts {
            if part.mimeType.type == "text" && part.mimeType.subtype ==  "plain" {
                if let decodedData = part.data?.rawData {
                    var decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) as String!
                    return decodedString
                }
            }
        }
        
        return nil
    }
    
    @IBAction func sliderUnlock(_ sender: Any) {
        print("Entsperren Slider triggered sliderUnlock (did end on exit, touch up inside)")
        if unlockSliderOut.value == 1 {
            if code == "" || code == nil {
                unlock()
            } else {
                codeMode = true
                UIView.animate(withDuration: 0.5) {
                    self.codeTopView.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.codeFieldA.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.codeFieldB.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.codeFieldC.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.codeFieldD.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.codePadImageView.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnA.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnB.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnC.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnD.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnE.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnF.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnG.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnH.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnI.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnJ.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnEmergency.transform = CGAffineTransform(translationX: 0, y: -285)
                    self.codePadBtnCancel.transform = CGAffineTransform(translationX: 0, y: -285)
                    
                    self.unlockBar.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.unlockSliderOut.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.entsperrenLabel.transform = CGAffineTransform(translationX: 375, y: -251)
                    self.cameraButtonImage.transform = CGAffineTransform(translationX: 375, y: -251)
                }
                
                self.dateLabel.isHidden = true
                self.timeLabel.font = UIFont(name: "Helvetica",size: 40)
                self.pushView.isHidden = true
                if self.mediaControlView.isHidden == false {
                    self.mediaControlView.isHidden = true
                    self.lsBar.isHidden = false
                }
                UIView.transition(with: timeLabel,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { [weak self] in
                                    self?.timeLabel.text = "Code eingeben"
                                    self!.MCMirrorCoverImageView.alpha = 0
                                  }, completion: nil)
                codePadBtnCancel.setTitle("Abbrechen", for: .normal)
                codePadBtnCancel.setImage(nil, for: .normal)
            }
        } else {
            unlockSliderOut.setValue(0, animated: true)
            entsperrenLabel.alpha = 1
        }
    }
    
    @objc func codeBtnPressed(_ sender: UIButton) {
        if sender.tag == 12 {
            if codePadBtnCancel.title(for: .normal) == "" {
                codeInput = String(codeInput.dropLast())
            } else {
                cancelCode()
            }
        } else if sender.tag == 10 {
            
        } else {
            codeInput = "\(codeInput+String(sender.tag))"
            print(codeInput)
        }
        
        var numChars = codeInput.characters.count ?? 0
        numChars = codeInput.characters.count ?? 0
        print(numChars)
        
        if numChars == 0 {
            codeFieldA.isHidden = true
            codeFieldB.isHidden = true
            codeFieldC.isHidden = true
            codeFieldD.isHidden = true
            codePadBtnCancel.setTitle("Abbrechen", for: .normal)
            codePadBtnCancel.setImage(nil, for: .normal)
            codePadBtnCancel.contentVerticalAlignment = .center
            codePadBtnCancel.contentHorizontalAlignment = .center
        }
        
        if numChars == 1 {
            codeFieldA.isHidden = false
            codeFieldB.isHidden = true
            codeFieldC.isHidden = true
            codeFieldD.isHidden = true
            if codePadBtnCancel.title(for: .normal) == "Abbrechen" {
                codePadBtnCancel.setTitle("", for: .normal)
                codePadBtnCancel.setImage(UIImage(named: "lsCodepadDeleteBtn"), for: .normal)
                codePadBtnCancel.contentVerticalAlignment = .fill
                codePadBtnCancel.contentHorizontalAlignment = .fill
                codePadBtnCancel.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
            }
        }
        if numChars == 2 {
            codeFieldA.isHidden = false
            codeFieldB.isHidden = false
            codeFieldC.isHidden = true
            codeFieldD.isHidden = true
        }
        if numChars == 3 {
            codeFieldA.isHidden = false
            codeFieldB.isHidden = false
            codeFieldC.isHidden = false
            codeFieldD.isHidden = true
        }
        if numChars == 4 {
            codeFieldA.isHidden = false
            codeFieldB.isHidden = false
            codeFieldC.isHidden = false
            codeFieldD.isHidden = false
            
            if codeInput == code {
                unlock()
            } else {
                deactivateInt += 1
                checkDeactivated()
                
                codeFieldD.isHidden = false
                let when = DispatchTime.now() + 0.15
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.codeInput = ""
                    self.codeFieldA.isHidden = true
                    self.codeFieldB.isHidden = true
                    self.codeFieldC.isHidden = true
                    self.codeFieldD.isHidden = true
                }
                
                codePadBtnCancel.setTitle("Abbrechen", for: .normal)
                codePadBtnCancel.setImage(nil, for: .normal)
                codePadBtnCancel.contentVerticalAlignment = .center
                codePadBtnCancel.contentHorizontalAlignment = .center
                
                lsBar.image = UIImage(named: "lsRedBarTexture")
                dateLabel.layer.opacity = 0
                pulseAnimation.duration = 0.1
                pulseAnimation.fromValue = 0
                pulseAnimation.toValue = 1
                pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                pulseAnimation.autoreverses = true
                pulseAnimation.repeatCount = 2
                self.dateLabel.layer.add(pulseAnimation, forKey: nil)
                dateLabel.layer.opacity = 1
                
                timeLabel.text = "Falscher Code"
                
                statusbarView.backgroundColor = UIColor(red: 220/255, green: 85/255, blue: 84/255, alpha: 0.5)
                
                dateLabel.text = "Wiederholen"
                dateLabel.isHidden = false
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
    
    func unlock() {
        self.performSegue(withIdentifier: "codePassed", sender: self)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "iphone_unlock", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            print("iphone_unlock (ofType: ´mp3´) could not be played")
        }
        
        player.play()
    }
    
    
    @objc func checkDeactivated() {
        if deactivateInt == 6 {
            //Disable phone
            self.performSegue(withIdentifier: "lockscreenToDeactivated", sender: self)
            print("Phone should be disabled, triggered by too many wrong code attempts.")
        }
        
        
    }
    
    func cancelCode() {
        codeMode = false
        UIView.animate(withDuration: 0.5) {
            self.codeTopView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codeFieldA.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codeFieldB.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codeFieldC.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codeFieldD.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnA.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnB.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnC.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnD.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnE.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnF.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnG.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnH.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnI.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnJ.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnEmergency.transform = CGAffineTransform(translationX: 0, y: 0)
            self.codePadBtnCancel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.unlockBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.unlockSliderOut.transform = CGAffineTransform(translationX: 0, y: 0)
            self.entsperrenLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.cameraButtonImage.transform = CGAffineTransform(translationX: 0, y: 0)
            UIView.transition(with: self.timeLabel,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self!.timeFormatter.timeStyle = .short
                                self!.timeLabel.text = self!.timeFormatter.string(from: NSDate() as Date)
                                self!.MCMirrorCoverImageView.alpha = 1
                              }, completion: nil)
            self.dateLabel.isHidden = false
            self.timeLabel.font = UIFont(name: "Helvetica Light", size: 76)
        }
        unlockSliderOut.setValue(0, animated: false)
        entsperrenLabel.alpha = 1
        lsBar.image = UIImage(named: "lsTopbarTextureB")
        statusbarView.backgroundColor = UIColor(red: 49/255, green: 54/255, blue: 59/255, alpha: 0.5)
        codeFieldA.isHidden = true
        codeFieldB.isHidden = true
        codeFieldC.isHidden = true
        codeFieldD.isHidden = true
        codeInput = ""
        updateTimer()
        
    }
    
    @IBAction func unlockSliderAlphaTrigger(_ sender: Any) {
        entsperrenLabel.alpha = CGFloat(self.unlockSliderOut.value.distance(to: 0.5))
    }
    
    @IBAction func touchUpOutside(_ sender: Any) {
        print("Entsperren Slider triggered touchUpOutside")
        if unlockSliderOut.value == 1 {
            sliderUnlock(self)
        } else {
            unlockSliderOut.isUserInteractionEnabled = false
            unlockSliderOut.setValue(0, animated: true)
            UIView.animate(withDuration: 0.5) {
                self.entsperrenLabel.alpha = 1
            }
            unlockSliderOut.isUserInteractionEnabled = true
        }
    }
    
    var cameraGrabberMoved = false
    
    @IBAction func cameraGrabberSlider(_ sender: Any) {
        batteryMirrorReflection.isHidden = true
        batteryMirrorImageView.isHidden = true
        mediaTimer.invalidate()
        batteryTimer.invalidate()
        let yPosition = CGFloat(Double(cameraGrabberSliderOut.value) * Double(view.frame.height-90))
        for object in cameraGrabberMoveUpOutlets {
            object.transform = CGAffineTransform(translationX: 0, y: -yPosition)
        }
        if cameraGrabberSliderOut.value > 0.01 {
            cameraGrabberMoved = true
        }
    }
    
    @IBAction func cameraGrabberSliderReleased(_ sender: Any) {
        print("released")
        if cameraGrabberSliderOut.value < 0.01 {
            print("cameraGrabber released with value under 0.01")
            if cameraGrabberMoved == true {} else {
                cameraGrabberSliderOut.isUserInteractionEnabled = false
                for object in self.cameraGrabberMoveUpOutlets {
                    UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: {
                        object.transform = CGAffineTransform(translationX: 0, y: -50)
                    })
                    UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
                        object.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                    UIView.animate(withDuration: 0.08, delay: 0.4, options: [], animations: {
                        object.transform = CGAffineTransform(translationX: 0, y: -10)
                    })
                    UIView.animate(withDuration: 0.15, delay: 0.5, options: [], animations: {
                        object.transform = CGAffineTransform(translationX: 0, y: 0)
                    }) { (finished) in
                        self.cameraGrabberSliderOut.isUserInteractionEnabled = true
                    }
                }
            }
            getCurrentMetadata()
            switchBattery()
            mediaTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(getCurrentMetadata), userInfo: nil, repeats: true)
            batteryTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchBattery), userInfo: nil, repeats: true)
        } else if cameraGrabberSliderOut.value < 0.4 {
            print("cameraGrabber released with value under 0.4")
            UIView.animate(withDuration: 0.3, animations: {
                for object in self.cameraGrabberMoveUpOutlets {
                    object.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }) { (finished) in
            }
            getCurrentMetadata()
            switchBattery()
            mediaTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(getCurrentMetadata), userInfo: nil, repeats: true)
            batteryTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchBattery), userInfo: nil, repeats: true)
        } else if cameraGrabberSliderOut.value >= 0.4 {
            print("cameraGrabber released with value above 0.4")
            UIView.animate(withDuration: 0.3, animations: {
                for object in self.cameraGrabberMoveUpOutlets {
                    object.transform = CGAffineTransform(translationX: 0, y: -812)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.performSegue(withIdentifier: "lockscreenToCamera", sender: self)
            }
        } else {
            print("cameraGrabber released with unknown value")
        }
        cameraGrabberSliderOut.setValue(0, animated: false)
        cameraGrabberMoved = false
        
    }
    
    @objc func getCurrentMetadata() {
        if playerSession.playbackState == .playing {
            playPauseImage.image = UIImage(named: "pause")
        } else {
            playPauseImage.image = UIImage(named: "play")
        }
        if let mediaItem = playerSession.nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
            let coverImage : UIImage? = mediaItem.artwork?.image(at: CGSize(width: 343, height: 343))
            
            if playerSession.playbackState == .playing {
                if codeMode == true {} else {
                    dateLabelContent = "title"
                    dateLabel.text = title
                    statusbarView.backgroundColor = UIColor.black
                }
                MCCoverImageView.image = coverImage
                MCCoverImageView.isHidden = false
                lsBattery.isHidden = true
                wallpaper.image = UIImage(named: "blackTexture.png")
                MCMirrorCoverImageView.image = coverImage
                MCMirrorCoverImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
                batteryMirrorReflection.isHidden = true
                batteryMirrorImageView.isHidden = true
            } else {
                dateLabelContent = "date"
                MCCoverImageView.isHidden = true
                MCMirrorCoverImageView.isHidden = true
                switch UIDevice.current.batteryState {
                case .charging:
                    lsBattery.isHidden = false
                    batteryMirrorReflection.isHidden = false
                    batteryMirrorImageView.isHidden = false
                case .full:
                    lsBattery.isHidden = false
                    batteryMirrorReflection.isHidden = false
                    batteryMirrorImageView.isHidden = false
                case .unknown:
                    lsBattery.isHidden = false
                    batteryMirrorReflection.isHidden = true
                    batteryMirrorImageView.isHidden = true
                case .unplugged:
                    wallpaper.image = UIImage(named: UserDefaults.standard.string(forKey: "wallpaperResourceString") ?? "100_iPad")
                    statusbarView.backgroundColor = UIColor(red: 49/255, green: 54/255, blue: 59/255, alpha: 0.7)
                    batteryMirrorReflection.isHidden = true
                    batteryMirrorImageView.isHidden = true
                    lsBattery.isHidden = false
                    
                default:
                    break
                }
            }
            
            MCartistLabel.text = artist
            MCTitleLabel.text = title
            MCAlbumLabel.text = albumTitle
            
            let currentRoute = AVAudioSession.sharedInstance().currentRoute
            
            
            for description in currentRoute.outputs {
                
                if description.portType == AVAudioSessionPortBuiltInSpeaker {
                    airPlayBtnOut.image = UIImage(named: "airtunes_lockscreen_off")
                } else {
                    airPlayBtnOut.image = UIImage(named: "airtunes_lockscreen_on")
                }
            }
        }
    }
    
    @objc func configureUI() {
        if playerSession.playbackState == .playing {
            playPauseImage.image = UIImage(named: "pause")
        } else {
            playPauseImage.image = UIImage(named: "play")
            
        }
    }
    
    @objc func updateTimer() {
        if codeMode == false {
            timeFormatter.timeStyle = .short
            timeLabel.text = timeFormatter.string(from: NSDate() as Date)
            dateFormatter.dateFormat = "EEEE, d. MMMM"
            if dateLabelContent == "date" {
                dateLabel.text = dateFormatter.string(from: NSDate() as Date)
            }
        }
    }
    
    func updateBatteryState() {
        let status = UIDevice.current.batteryState
        switch status {
        case .full:
            wallpaper.image = UIImage(named: "blackTexture.png")
            lsBattery.isHidden = false
            cautionImg.isHidden = true
            statusbarView.backgroundColor = UIColor.black
            batteryMirrorReflection.isHidden = false
            batteryMirrorImageView.isHidden = false
        case .unplugged:
            wallpaper.image = UIImage(named: UserDefaults.standard.string(forKey: "wallpaperResourceString") ?? "100_iPad")
            lsBattery.isHidden = true
            batteryMirrorReflection.isHidden = true
            batteryMirrorImageView.isHidden = true
            cautionImg.isHidden = true
            switchBattery()
            statusbarView.backgroundColor = UIColor(red: 49/255, green: 54/255, blue: 59/255, alpha: 0.7)
        case .charging:
            wallpaper.image = UIImage(named: "blackTexture.png")
            lsBattery.isHidden = false
            batteryMirrorReflection.isHidden = false
            batteryMirrorImageView.isHidden = false
            statusbarView.backgroundColor = UIColor.black
            if let asset = NSDataAsset(name:"charging"){
                do {
                    player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                    player.play()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            cautionImg.isHidden = true
            
            
        case .unknown:
            wallpaper.image = UIImage(named: "blackTexture.png")
            lsBattery.isHidden = true
            batteryMirrorReflection.isHidden = true
            batteryMirrorImageView.isHidden = true
            lsBattery.image = UIImage(named: "ls0.png")
            cautionImg.isHidden = false
            statusbarView.backgroundColor = UIColor.black
        }
    }
    
    @objc func batteryStateDidChange() {
        self.updateBatteryState()
    }
    
    @objc func switchBattery() {
        if UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full {
            switch MyBattery {
            case 100.0:
                lsBattery.image = UIImage(named: "lsBatteryBG17.png")
                
            case 96.0...99.0:
                lsBattery.image = UIImage(named: "lsBatteryBG16.png")
                
            case 90.0...95.0:
                lsBattery.image = UIImage(named: "lsBatteryBG15.png")
                
            case 85.0...89.0:
                lsBattery.image = UIImage(named: "lsBatteryBG14.png")
                
            case 78.0...84.0:
                lsBattery.image = UIImage(named: "lsBatteryBG13.png")
                
            case 70.0...77.0:
                lsBattery.image = UIImage(named: "lsBatteryBG12.png")
                
            case 63.0...69.0:
                lsBattery.image = UIImage(named: "lsBatteryBG11.png")
                
            case 56.0...62.0:
                lsBattery.image = UIImage(named: "lsBatteryBG10.png")
                
            case 49.0...55.0:
                lsBattery.image = UIImage(named: "lsBatteryBG9.png")
                
            case 42.0...48.0:
                lsBattery.image = UIImage(named: "lsBatteryBG8.png")
                
            case 35.0...41.0:
                lsBattery.image = UIImage(named: "lsBatteryBG7.png")
                
            case 28.0...34.0:
                lsBattery.image = UIImage(named: "lsBatteryBG6.png")
                
            case 21.0...27.0:
                lsBattery.image = UIImage(named: "lsBatteryBG5.png")
                
            case 14.0...20.0:
                lsBattery.image = UIImage(named: "lsBatteryBG4.png")
                
            case 7.0...13.0:
                lsBattery.image = UIImage(named: "lsBatteryBG3.png")
                
            case 1.1...6.0:
                lsBattery.image = UIImage(named: "lsBatteryBG2.png")
                
            case 1.0:
                lsBattery.image = UIImage(named: "lsBatteryBG1.png")
                
            case 0.0:
                lsBattery.image = UIImage(named: "lsBatteryBG1.png")
            default:
                print(" ")
            }
            batteryMirrorReflection.isHidden = false
            batteryMirrorImageView.isHidden = false
            batteryMirrorImageView.image = lsBattery.image
            batteryMirrorImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
    
    
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    func startShimmering(){
        let light = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.4).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 6 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 2
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering(){
        self.layer.mask = nil
    }
    
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
