//
//  musicViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 30.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation


class musicViewController: UIViewController, MPMediaPickerControllerDelegate {
    @IBOutlet var playerCoverImageView: UIImageView!
    @IBOutlet var playerTitleLabel: UILabel!
    @IBOutlet var playerArtistLabel: UILabel!
    @IBOutlet var playerAlbumLabel: UILabel!
    @IBOutlet var playerRouteBtnOut: UIButton!
    @IBOutlet var playerScrubberOut: UISlider!
    @IBOutlet var playerTimeEclapsedLabel: UILabel!
    @IBOutlet var playerTimeLeftLabel: UILabel!
    @IBOutlet var playerBackBtnOut: UIButton!
    @IBOutlet var playerNextBtnOut: UIButton!
    @IBOutlet var playerPlayPauseOut: UIButton!
    @IBOutlet var playerVolumeSliderOut: UISlider!
    
    
    let player = MPMusicPlayerController.systemMusicPlayer
    var durationSliderIsInUse = Bool()
    var noPlaybackHandled = Bool()

    @IBAction func playPauseBtn(_ sender: Any) {
        if player.playbackState == .playing {
            DispatchQueue.main.async {
                self.player.pause()
                self.playerPlayPauseOut.setBackgroundImage(UIImage(named: "play"), for: .normal)
            }
        } else if player.playbackState == .paused {
            DispatchQueue.main.async {
                self.player.play()
                self.playerPlayPauseOut.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.player.play()
            }
            
        }
        
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
        
    }
    
    @IBAction func nextTitle(_ sender: Any) {
        self.player.skipToNextItem()
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    @IBAction func previousTitle(_ sender: Any) {
        self.player.skipToPreviousItem()
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    @IBAction func durationSliderStart(_ sender: Any) {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    @IBAction func durationSliderChanged(_ sender: Any) {
        durationSliderIsInUse = true
        player.pause()
        player.currentPlaybackTime = TimeInterval(playerScrubberOut.value)
    }
    
    @objc func sliderDidEndSliding() {
        player.currentPlaybackTime = TimeInterval(playerScrubberOut.value)
        player.play()
        durationSliderIsInUse = false
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
    }
    
    func handleNoPlayback() {
        if noPlaybackHandled == true {} else {
            //Handle no playback
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerScrubberOut.addTarget(self, action: #selector(sliderDidEndSliding), for: [.touchUpInside, .touchUpOutside])
       // detectAudioRoute()
        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self,
//                                       selector: #selector(detectAudioRoute),
//                                       name: AVAudioSession.routeChangeNotification,
//                                       object: nil)
        
        prepareUI()
        getMetadata()
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMetadata), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMetadata), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        player.beginGeneratingPlaybackNotifications()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleDurationSlider), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerCoverImageView.roundCorners(corners: [.allCorners], radius: 10)
        do {
            var volumeView = MPVolumeView()
            volumeView = MPVolumeView(frame: playerVolumeSliderOut.frame)
            volumeView.showsRouteButton = false
            let temp = volumeView.subviews
            for current in temp {
                if current.isKind(of: UISlider.self) {
                    let tempSlider = current as! UISlider
                    tempSlider.minimumTrackTintColor = UIColor.white
                    tempSlider.maximumTrackTintColor = UIColor.lightGray
                }
            }
            view.addSubview(volumeView)
        } catch {}
        
    }
    
    @objc func handleDurationSlider() {
        let trackElapsed = player.currentPlaybackTime
        let trackDuration = player.nowPlayingItem?.playbackDuration
        var timeLeft = trackDuration! - trackElapsed
        
        playerTimeEclapsedLabel.text = ("\(trackElapsed.stringTimeDigits)")
        playerTimeLeftLabel.text = ("-\(timeLeft.stringTimeDigits)")
        
        if durationSliderIsInUse == true {} else {
            playerScrubberOut.value = Float(trackElapsed)
        }
        
    }
    		
    func prepareUI() {
        if player.playbackState == .playing {
            self.playerPlayPauseOut.setImage(UIImage(named: "playerIconPause"), for: .normal)
        } else if player.playbackState == .paused {
            self.playerPlayPauseOut.setImage(UIImage(named: "playerIconPlay"), for: .normal)
        }
    }
    
    @objc func getMetadata() {
        if player.playbackState == .stopped {
            handleNoPlayback()
        } else {
            noPlaybackHandled = false
            if let mediaItem = player.nowPlayingItem {
                let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
                let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
                let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
                let trackDuration = player.nowPlayingItem?.playbackDuration
                playerTitleLabel.text = title
                playerArtistLabel.text = artist
                playerAlbumLabel.text = albumTitle
                playerScrubberOut.maximumValue = Float(trackDuration!)
                if durationSliderIsInUse == true {} else {
                    if player.playbackState == .playing {
                        self.playerPlayPauseOut.setImage(UIImage(named: "playerIconPause"), for: .normal)
                    } else if player.playbackState == .paused {
                        self.playerPlayPauseOut.setImage(UIImage(named: "playerIconPlay"), for: .normal)
                    }
                }
                let coverImage : UIImage? = player.nowPlayingItem?.artwork?.image(at: CGSize(width: 60, height: 60))
                playerCoverImageView.image = coverImage
            }
        }
    }
}

//MARK: TimeInterval Convert
extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    private var stringHours: String {
        return "\(hours)"
    }
    
    private var stringMinutes: String {
        return "\(minutes)"
    }
    
    private var stringSeconds: String {
        if seconds <= 9 {
            return "0\(seconds)"
        } else {
            return "\(seconds)"
        }
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
    
    var stringTimeDigits: String {
        if hours != 0 {
            return "\(stringHours):\(stringMinutes):\(stringSeconds)"
        } else if minutes != 0 {
            return "\(stringMinutes):\(stringSeconds)"
        } else {
            return "0:\(stringSeconds)"
        }
    }
}
