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
    var dataPedido:String
    var statusPedido:String
    var pedidoAceite:Bool
    
    init(valorTotalProduto:Double,dataPedido:String,statusPedido:String,pedidoAceite:Bool
){
        self.valorTotalProduto = valorTotalProduto
        self.dataPedido = dataPedido
        self.statusPedido = statusPedido
        self.pedidoAceite = pedidoAceite
    }
    
    func toDict (_ valoresPedido : ValoresPedido) -> [String:Any]{
        return [
            "valorTotalProduto":valoresPedido.valorTotalProduto,
            "dataPedido":valoresPedido.dataPedido,
            "statusPedido":valoresPedido.statusPedido,
            "pedidoAceite":valoresPedido.pedidoAceite,
        ]
    }
    
    init( valoresPedidoJSON : [String : Any]) {
        self.valorTotalProduto = valoresPedidoJSON["valorTotalProduto"] as? Double ?? 0.0
        self.dataPedido = valoresPedidoJSON["dataPedido"] as? String ?? ""
        self.statusPedido =  valoresPedidoJSON["statusPedido"] as? String ?? ""
        self.pedidoAceite  = valoresPedidoJSON["pedidoAceite"] as? Bool ?? false
    }
}

