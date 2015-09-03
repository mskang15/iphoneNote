//
//  MasterTableViewCell.swift
//  Notes
//
//  Created by Moon-Seok Kang on 6/18/15.
//  Copyright (c) 2015 Moon Kang. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var masterTitleLabel: UILabel!
    @IBOutlet weak var masterTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
