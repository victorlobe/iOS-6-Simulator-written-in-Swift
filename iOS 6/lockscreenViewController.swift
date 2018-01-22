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
import ReachabilitySwift
import MediaPlayer
import Shimmer

class lockscreenViewController: UIViewController {
    let reachability = Reachability()!

    
    var player: AVAudioPlayer = AVAudioPlayer()
    let playerSession = MPMusicPlayerController.systemMusicPlayer


    @IBOutlet var lsBar: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var slidetounlock: UILabel!
    @IBOutlet var networkImage: UIImageView!
    @IBOutlet var MCTimeLabel: UILabel!
    
    @IBOutlet var unlockArrowOut: UIButton!
    
    @IBOutlet var unlockArrowImg: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet var unlockArrowBoundaries: UIView!
    
    @IBOutlet var wallpaper: UIImageView!
    @IBOutlet var lsBattery: UIImageView!
    @IBOutlet var statusBarView: UIView!
    @IBOutlet var cautionImg: UIImageView!
    
    
    @IBOutlet var mediaControlView: UIView!
    
    @IBOutlet var MCartistLabel: UILabel!
    
    @IBOutlet var MCTitleLabel: UILabel!
    
    @IBOutlet var MCAlbumLabel: UILabel!
    
    @IBOutlet var MCVolSliderOut: UISlider!
    
    @IBOutlet var unlockSliderOut: UISlider!
    
    @IBOutlet var entsperrenLabel: UILabel!
    
    @IBOutlet var entsperrenShimmerView: FBShimmeringView!
    
    
    
    private let wrapperLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    
    var gradientColors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = gradientColors.map({ $0.cgColor })
        }
    }
    
    @IBAction func unlockArrowBtn(_ sender: Any) {
        
        
        
    }
    
    
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    let emptyString = String() // Do nothing
    var batteryState = UIDevice.current.batteryState

            
    
    @IBOutlet var playPauseOut: UIButton!
    @IBOutlet var lastOut: UIButton!
    @IBOutlet var nextOut: UIButton!
    
    @IBOutlet var volumeSliderOut: UISlider!
    
    
    @IBAction func switchMCView(_ sender: Any) {
        
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
    
    
    @IBAction func playPause(_ sender: Any) {
        if playerSession().playbackState == .playing {
            playerSession().pause()
            playPauseOut.setImage(#imageLiteral(resourceName: "lsMediaControlPlay"), for: .normal)
            
        } else {
            playerSession().play()
            playPauseOut.setImage(#imageLiteral(resourceName: "lsMediaControlPause"), for: .normal)
            
        }
    }
    
    @IBAction func last(_ sender: Any) {
        playerSession().skipToPreviousItem()
    }
    
    @IBAction func next(_ sender: Any) {
        playerSession().skipToNextItem()
    }
    
    
    @IBAction func volumeSlider(_ sender: Any) {
        let volumeSlider = (MPVolumeView().subviews.filter { NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as! UISlider)
        volumeSlider.setValue((sender as AnyObject).value, animated: false)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
            
            
            
    override func viewWillAppear(_ animated: Bool) {
        
        
                self.unlockSliderOut.setThumbImage(UIImage(named: "unlockArrowResized"), for: UIControlState.normal)
        
        
        
        
        unlockSliderOut.addTarget(self, action: #selector(self.sliderDidEndSliding), for: .touchUpInside)
        
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

        
        
        // Setup the Network Info and create a CTCarrier object
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        
        // Get carrier name
        let carrierName = carrier?.carrierName

        print(carrierName)
        lsBattery.isHidden = true
        
        

        
        
        
        
        
        self.updateBatteryState()

        
        
        
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        dateLabel.text = "\(formatter.string(from: date))"
        
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkNetwork), userInfo: nil, repeats: true)
        
                        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getCurrentMetadata), userInfo: nil, repeats: true)
        
        //timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(checkCurrentVolume), userInfo: nil, repeats: true)
        
        
        checkCurrentVolume()
        
        let batteryLevel = UIDevice.current.batteryLevel*100
        
        
        
        print ("My Battery:\(batteryLevel)")
        
        
        MyBattery = batteryLevel
        
        switchBattery()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lockscreenViewController.batteryStateDidChange),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange,
                                               object: nil)

        
        self.entsperrenShimmerView.contentView = entsperrenLabel
        self.entsperrenShimmerView.isShimmering = true
        self.entsperrenShimmerView.shimmeringSpeed = 50
        
        mediaControlView.isHidden = true
        configureUI()
        
        
        self.MCVolSliderOut.setMinimumTrackImage(UIImage(named: "sliderTrackTintTexture"), for: UIControlState.normal)
        
        self.MCVolSliderOut.setMaximumTrackImage(UIImage(named: "sliderTrackLeftTintTexture"), for: UIControlState.normal)
        
        self.MCVolSliderOut.setThumbImage(UIImage(named: "bottombarknobgray@2x~iphone"), for: UIControlState.normal)
        let frame = CGRect(x: -1000, y: -1000, width: 100, height: 100)
        let volumeView = MPVolumeView(frame: frame)
        volumeView.sizeToFit()
        self.view!.addSubview(volumeView)
        
    }
    
    
    
    
    
    
    @IBAction func sliderUnlock(_ sender: Any) {
        if unlockSliderOut.value == 1 {
            self.performSegue(withIdentifier: "toCode", sender: self)
        } else {
            unlockSliderOut.setValue(0, animated: true)
            entsperrenLabel.alpha = 1
        }
    }
    
    
    @objc func sliderDidEndSliding() {

    }
    
    
    
    @IBAction func unlockSliderAlphaTrigger(_ sender: Any) {
        entsperrenLabel.alpha = CGFloat(self.unlockSliderOut.value.distance(to: 0.5))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
     func checkCurrentVolume() {
        //let audioSession = AVAudioSession.sharedInstance()
        //let volume : Float = audioSession.outputVolume
        //volumeSliderOut.value = volume
        
    }
    
    
    
    
    
    
    @objc func getCurrentMetadata() {
        if let mediaItem = playerSession().nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
            
            dateLabel.text = title

            MCartistLabel.text = artist
            MCTitleLabel.text = title
            MCAlbumLabel.text = albumTitle
        }
    }
    
    
    @objc func configureUI() {
        if playerSession().playbackState == .playing {
            playPauseOut.setImage(#imageLiteral(resourceName: "lsMediaControlPause"), for: .normal)
            
        } else {
            playPauseOut.setImage(#imageLiteral(resourceName: "lsMediaControlPlay"), for: .normal)
            
        }
        
        
        
        
        
    }
    
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
                MCTimeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    @IBOutlet var statusBarContainer: UIView!
    
    func updateBatteryState() {
        
        let status = UIDevice.current.batteryState
        switch status {
        
        case .full:
            wallpaper.image = UIImage(named: "blackTexture.png")
            lsBattery.isHidden = false
            cautionImg.isHidden = true
            
        case .unplugged:
            wallpaper.image = UIImage(named: "wall.png")
            lsBattery.isHidden = true
            cautionImg.isHidden = true
            switchBattery()

        case .charging:
            wallpaper.image = UIImage(named: "blackTexture.png")
            lsBattery.isHidden = false
            
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
            lsBattery.isHidden = false
            lsBattery.image = UIImage(named: "ls0.png")
            cautionImg.isHidden = false
        }
        
    }
    
    func batteryStateDidChange() {
        self.updateBatteryState()
    }
    
    func switchBattery() {
        
        
        switch MyBattery {
            
        case 91.0...100.0:
            lsBattery.image = UIImage(named: "ls16.png")
            
        case 81.0..<90.0:
            lsBattery.image = UIImage(named: "ls15.png")
            
            
        case 71.0..<80.0:
            lsBattery.image = UIImage(named: "ls14.png")
            
            
        case 61.0..<70.0:
            lsBattery.image = UIImage(named: "ls10.png")
            
            
        case 51.0..<60.0:
            lsBattery.image = UIImage(named: "ls8.png")
            
            
        case 41.0..<50.0:
            lsBattery.image = UIImage(named: "ls7.png")
            
            
        case 31.0..<40.0:
            lsBattery.image = UIImage(named: "ls5.png")
            
            
        case 21.0..<30.0:
            lsBattery.image = UIImage(named: "ls4.png")
            
            
        case 16.0..<20.0:
            lsBattery.image = UIImage(named: "ls3.png")
            
            
        case 11.0..<15.0:
            lsBattery.image = UIImage(named: "ls2.png")
            
            
        case 6.0..<10.0:
            lsBattery.image = UIImage(named: "ls2.png")
            
            
        case 0.0..<5.0:
            lsBattery.image = UIImage(named: "ls1.png")
            
            
            
            
        default:
            print(" ")
            
            
            
        }
        
        
        
    }
    
    
    @objc func checkNetwork() {
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






