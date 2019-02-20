//
//  PedidosAdegaTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 18/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class PedidosAdegaTableViewCell: UITableViewCell {

    @IBOutlet weak var statusPedido: UILabel!
    @IBOutlet weak var timerPedido: UILabel!
    @IBOutlet weak var distanciaEntrega: UILabel!
    @IBOutlet weak var valorTotal: UILabel!
    @IBOutlet weak var nomeEnumeroPedido: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
