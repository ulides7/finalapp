//
//  PostTableViewCell.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-02.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenprofil: UIImageView!
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var fechapub: UILabel!
    
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var imagenpost: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
