//
//  StoriesTableViewCell.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-03.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var perfil: UIImageView!
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    @IBOutlet weak var descrip: UILabel!
    
    @IBOutlet weak var imapost: UIImageView!
    @IBOutlet weak var likes: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
}
