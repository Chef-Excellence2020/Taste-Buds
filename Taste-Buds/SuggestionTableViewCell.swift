//
//  SuggestionTableViewCell.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/7/20.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var Suggestions: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
