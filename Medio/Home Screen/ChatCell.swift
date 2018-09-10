//
//  ChatCell.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 27/04/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var UserMessage: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
