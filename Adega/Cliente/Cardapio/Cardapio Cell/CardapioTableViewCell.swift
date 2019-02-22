//
//  CardapioTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 02/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class CardapioTableViewCell: UITableViewCell {

    @IBOutlet weak var nome_produto: UILabel!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
