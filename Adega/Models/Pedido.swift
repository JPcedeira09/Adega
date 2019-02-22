//
//  Pedido.swift
//  Adega
//
//  Created by Joao Paulo on 15/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct Pedido {

    var key:String
    var valoresPedido:ValoresPedido
    var usuario:Usuario
    var itensCarrinho:[ItensCarrinho]
    
    func toString(){
        print(key)
        print(valoresPedido)
        print(usuario)
        print(itensCarrinho)
    }
    
    init(key:String,valoresPedido:ValoresPedido,usuario:Usuario, itensCarrinho:[ItensCarrinho]) {
        self.key = key
        self.valoresPedido = valoresPedido
        self.itensCarrinho = itensCarrinho
        self.usuario = usuario

    }
    
    func toDict (_ pedido : Pedido) -> [String:Any]{
        
        var dictItens = [[String:Any]]()
        for x in pedido.itensCarrinho {
           dictItens.append(x.toDict(x))
        }
        
        return ["ValoresPedido":pedido.valoresPedido.toDict(pedido.valoresPedido),
                "DadosCliente":pedido.usuario.toDict(pedido.usuario),
                "Itens":dictItens,
                "key":pedido.key
]
    }
    
    init( pedidoJSON : [String : Any]) {
        
        self.valoresPedido = ValoresPedido.init(valoresPedidoJSON: pedidoJSON["ValoresPedido"] as? [String : Any] ?? [:])
        self.itensCarrinho = [ItensCarrinho.init(itensCarrinhoJSON: pedidoJSON["Itens"] as? [String : Any] ?? [:])]
        self.usuario = Usuario.init(usuarioJSON: pedidoJSON["DadosCliente"] as? [String : Any] ?? [:])
        self.key = pedidoJSON["key"] as? String ?? ""

    }
}
