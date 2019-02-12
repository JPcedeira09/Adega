//
//  ValoresPedido.swift
//  Adega
//
//  Created by Joao Paulo on 12/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation


struct ValoresPedido {
    
    var valorTotalProduto:Double

    init(valorTotalProduto:Double){
        self.valorTotalProduto = valorTotalProduto
    }
    
    func toDict (_ valoresPedido : ValoresPedido) -> [String:Any]{
        return ["valorTotalProduto":valoresPedido.valorTotalProduto]
    }
    
    init( valoresPedidoJSON : [String : Any]) {
        self.valorTotalProduto = valoresPedidoJSON["valorTotalProduto"] as? Double ?? 0.0
    }
}

