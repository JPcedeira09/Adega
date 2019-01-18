//
//  PedidosAdegaTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 18/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class PedidosAdegaTableViewCell: UITableViewCell {

    @IBOutlet weak var numeroPedido: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var distancia: UILabel!
    @IBOutlet weak var valorTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
