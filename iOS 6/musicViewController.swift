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

    override func viewDidLoad() {
        super.viewDidLoad()

        let mediaPicker = MPMediaPickerController(mediaTypes: .music)
        mediaPicker.delegate = self
        present(mediaPicker, animated: true, completion: {})
        
        
    }

    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        //User selected a/an item(s).
        for mpMediaItem in mediaItemCollection.items {
            print("Add \(mpMediaItem) to a playlist, prep the player, etc.")
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        print("User selected Cancel tell me what to do")
        self.performSegue(withIdentifier: "toLock", sender: Any)
    }
}
