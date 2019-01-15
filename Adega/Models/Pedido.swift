//
//  Pedido.swift
//  Adega
//
//  Created by Joao Paulo on 15/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct Pedido {

    var nomeProduto:String
    var quantidadeProduto:Int
    var valorTotalProduto:Double
    var usuarioComprador:[String : Any]
    
    init(nomeProduto:String, quantidadeProduto:Int,valorTotalProduto:Double, usuarioComprador:[String : Any]) {
        
        self.nomeProduto = nomeProduto
        self.quantidadeProduto = quantidadeProduto
        self.valorTotalProduto = valorTotalProduto
        self.usuarioComprador = usuarioComprador
    }
    
    func toDict (_ pedido : Pedido) -> [String:Any]{
        
        return ["nomeProduto":pedido.nomeProduto,
                "quantidadeProduto":pedido.quantidadeProduto,
                "valorTotalProduto":pedido.valorTotalProduto,
                "usuarioComprador":pedido.usuarioComprador
        ]
    }
    
    init( pedidoJSON : [String : Any]) {
        
        self.nomeProduto = pedidoJSON["nomeProduto"] as? String ?? ""
        self.quantidadeProduto = pedidoJSON["quantidadeProduto"] as? Int ?? 0
        self.valorTotalProduto =  pedidoJSON["valorTotalProduto"] as? Double ?? 0.0
        self.usuarioComprador = pedidoJSON["usuarioComprador"] as? [String : Any] ?? [:]
    }
}
