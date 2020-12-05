//
//  PreviewTableViewCell.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/5/20.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
