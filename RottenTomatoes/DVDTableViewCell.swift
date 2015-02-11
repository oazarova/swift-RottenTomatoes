//
//  DVDTableViewCell.swift
//  RottenTomatoes
//
//  Created by Olga Azarova on 2/9/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//

import UIKit

class DVDTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}