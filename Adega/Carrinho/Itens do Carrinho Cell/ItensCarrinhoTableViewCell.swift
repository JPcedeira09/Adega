//
//  ItensCarrinhoTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 10/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class ItensCarrinhoTableViewCell: UITableViewCell {

    @IBOutlet weak var quantidadeNome: UILabel!
    @IBOutlet weak var valorTotal: UILabel!
    @IBOutlet weak var botao: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
