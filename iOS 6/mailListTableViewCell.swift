//
//  mailListTableViewCell.swift
//  iOS 6
//
//  Created by Victor Lobe on 25.04.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class mailListTableViewCell: UITableViewCell {
    @IBOutlet var absenderLabel: UILabel!
    @IBOutlet var betreffLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var receivedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
