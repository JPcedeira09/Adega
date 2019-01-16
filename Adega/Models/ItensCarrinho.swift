//
//  ItensCarrinho.swift
//  Adega
//
//  Created by Joao Paulo on 16/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct ItensCarrinho {
    
    var qtd:Int
    var nome:String
    var totalItem:Double
    
    init(qtd:Int,nome:String,totalItem:Double) {
        self.qtd = qtd
        self.nome = nome
        self.totalItem = totalItem
    }
    
    func toDict (_ itensCarrinho : ItensCarrinho) -> [String:Any]{
        
        return ["qtd":itensCarrinho.qtd,
                "nome":itensCarrinho.nome,
                "totalItem":itensCarrinho.totalItem
        ]
    }
    
    init( itensCarrinhoJSON : [String : Any]) {
        
        self.qtd = itensCarrinhoJSON["qtd"] as? Int ?? 0
        self.nome = itensCarrinhoJSON["nome"] as? String ?? ""
        self.totalItem =  itensCarrinhoJSON["totalItem"] as? Double ?? 0.0
    }
    
}
