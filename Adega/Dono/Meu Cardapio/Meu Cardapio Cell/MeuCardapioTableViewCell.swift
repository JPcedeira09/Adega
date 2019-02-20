//
//  MeuCardapioTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class MeuCardapioTableViewCell: UITableViewCell {

    @IBOutlet weak var nome_produto: UILabel!
    @IBOutlet weak var disponibilidade: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var valorProduto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
