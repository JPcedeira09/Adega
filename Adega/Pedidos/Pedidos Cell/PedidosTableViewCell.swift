//
//  PedidosTableViewCell.swift
//  Adega
//
//  Created by Joao Paulo on 02/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class PedidosTableViewCell: UITableViewCell {

    @IBOutlet weak var distancia: UILabel!
    @IBOutlet weak var pedido: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
