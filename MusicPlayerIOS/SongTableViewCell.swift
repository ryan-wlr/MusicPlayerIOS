//
//  SongTableViewCell.swift
//  MusicPlayerIOS
//
//  Created by Ryan Weiler on 3/30/17.
//  Copyright © 2017 Ryan Weiler. All rights reserved.
//

import Foundation
import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
