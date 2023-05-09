//
//  FeedCell.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 4/5/23.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedUsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
