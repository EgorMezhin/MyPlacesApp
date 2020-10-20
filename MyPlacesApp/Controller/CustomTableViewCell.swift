//
//  CustomTableViewCell.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 21.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageOfPlace: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet var ratingCollection: [UIImageView]!
    @IBOutlet weak var testLabel: UILabel!
}
