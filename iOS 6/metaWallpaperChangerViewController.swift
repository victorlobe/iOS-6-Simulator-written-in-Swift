//
//  metaWallpaperChangerViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 11.05.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class metaWallpaperChangerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
        let reuseIdentifier = "metaWallpaperChangerCollectionViewCell" // also enter this string as the cell identifier in the storyboard
        var items = ["100_iPad", "101_iPad", "102_iPad", "104_iPad", "115_iPad", "116_iPad", "117_iPad", "119_iPad", "121_iPad", "122_iPad", "128_iPad", "132_iPad", "134_iPad", "1231_iPad", "1232_iPad", "1233_iPad", "1234_iPad", "1235_iPad", "1291_iPad", "1292_iPad", "1293_iPad", "1294_iPad", "1295_iPad", "linenPhonesize", "setupLinen", "leatherTexture", "blackTexture"]
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

        // MARK: - UICollectionViewDataSource protocol

        // tell the collection view how many cells to make
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.items.count
        }

        // make a cell for each cell index path
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! metaWallpaperChangerCollectionViewCell

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.previewImageView.image = UIImage(named: self.items[indexPath.item])

            return cell
        }

        // MARK: - UICollectionViewDelegate protocol

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
            UserDefaults.standard.set(items[indexPath.item], forKey: "wallpaperResourceString")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
