//
//  adressBookTableViewCell.swift
//  iOS 6
//
//  Created by Victor Lobe on 13.05.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class adressBookTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
