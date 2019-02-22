//
//  Pedido.swift
//  Adega
//
//  Created by Joao Paulo on 15/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct Pedido {

    var valoresPedido:ValoresPedido
    var usuario:Usuario
    var itensCarrinho:[ItensCarrinho]
    
    init(valoresPedido:ValoresPedido,usuario:Usuario, itensCarrinho:[ItensCarrinho]) {

        self.valoresPedido = valoresPedido
        self.itensCarrinho = itensCarrinho
        self.usuario = usuario

    }
    
    func toDict (_ pedido : Pedido) -> [String:Any]{
        
        return ["ValoresPedido":pedido.valoresPedido,
                "DadosCliente":pedido.usuario,
                "Itens":pedido.itensCarrinho      ]
    }
    
    init( pedidoJSON : [String : Any]) {
        
        self.valoresPedido = ValoresPedido.init(valoresPedidoJSON: pedidoJSON["ValoresPedido"] as? [String : Any] ?? [:])
        self.itensCarrinho = [ItensCarrinho.init(itensCarrinhoJSON: pedidoJSON["Itens"] as? [String : Any] ?? [:])]
        self.usuario = Usuario.init(usuarioJSON: pedidoJSON["DadosCliente"] as? [String : Any] ?? [:])


    }
}
