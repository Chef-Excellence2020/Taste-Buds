//
//  DetailsTableViewCell.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/7/20.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeDetails: UILabel!
    
    @IBOutlet weak var egg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
