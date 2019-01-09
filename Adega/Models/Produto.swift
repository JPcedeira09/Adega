//
//  Produtos.swift
//  Adega
//
//  Created by Joao Paulo on 09/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation
import UIKit

struct Produto {
    
    var nome:String
    var descricao:String
    var quantidade:Int
    //var imagem:UIImage
    var valor:Double
    var disponivel:Bool
    
    init(nome:String,descricao:String, quantidade:Int,  valor:Double, disponivel:Bool){
        //imagem:UIImage,
        self.nome = nome
        self.descricao = descricao
        self.quantidade = quantidade
        //self.imagem = imagem
        self.valor = valor
        self.disponivel = disponivel
    }
    
    func toDict (_ produto : Produto) -> [String:Any]{
        return ["nome":produto.nome,
                "descricao":produto.descricao,
                "quantidade":produto.quantidade,
                //"imagem":produto.imagem,
                "valor":produto.valor,
                "disponivel":produto.disponivel
        ]
    }
    
    init( produtoJSON : [String : Any]) {
        self.nome = produtoJSON["nome"] as? String ?? ""
        self.descricao =  produtoJSON["descricao"] as? String ?? ""
        self.quantidade = produtoJSON["quantidade"] as? Int ?? 0
       // self.imagem = produtoJSON["imagem"] as? UIImage ?? UIImage(named: "image_default")!
        self.valor =  produtoJSON["valor"] as? Double ?? 0.0
        self.disponivel = produtoJSON["disponivel"] as? Bool ?? true
    }
}

