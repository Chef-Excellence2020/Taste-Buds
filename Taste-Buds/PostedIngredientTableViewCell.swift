//
//  PostedIngredientTableViewCell.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/1/20.
//

import UIKit

class PostedIngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
