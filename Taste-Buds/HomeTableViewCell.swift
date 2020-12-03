//
//  HomeTableViewCell.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DishPic: UIImageView!
    
    @IBOutlet weak var dishName: UILabel!
    
    @IBOutlet weak var saves: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var dishDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
