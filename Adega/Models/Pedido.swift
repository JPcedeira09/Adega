//
//  Pedido.swift
//  Adega
//
//  Created by Joao Paulo on 15/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct Pedido {

    var valorTotalProduto:Double
    var itensCarrinho:[ItensCarrinho]
    
    init(valorTotalProduto:Double, itensCarrinho:[ItensCarrinho]) {

        self.valorTotalProduto = valorTotalProduto
        self.itensCarrinho = itensCarrinho
    }
    
    func toDict (_ pedido : Pedido) -> [String:Any]{
        
        return ["valorTotalProduto":pedido.valorTotalProduto,
                "itensCarrinho":pedido.itensCarrinho
        ]
    }
    
//    init( pedidoJSON : [String : Any]) {
//        self.valorTotalProduto =  pedidoJSON["valorTotalProduto"] as? Double ?? 0.0
//        self.itensCarrinho = pedidoJSON["itensCarrinho"] as? [String : Any] ?? [:]
//    }
}
