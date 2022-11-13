//
//  CustomCell.swift
//  ToDoListApp
//
//  Created by Kisu on 2022-11-13.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var TaskTitle: UILabel!
    @IBOutlet weak var TaskSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
