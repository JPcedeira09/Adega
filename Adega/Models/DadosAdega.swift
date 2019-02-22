//
//  DadosAdega.swift
//  Adega
//
//  Created by Joao Paulo on 21/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation


struct DadosAdega {
    
    var CEP:String
    var CNPJ:String
    var aberto:Bool
    var endereco:String
    var horarioAberto:String
    var horarioFechado:String
    var nome:String
    var numero:String
    var raioDeEntrega:Int
    var telefone1:String
    var telefonen2:String

    init(CEP:String,CNPJ:String,aberto:Bool,endereco:String,horarioAberto:String,horarioFechado:String,nome:String,numero:String,raioDeEntrega:Int,telefone1:String,telefonen2:String) {
        self.CEP = CEP
        self.CNPJ = CNPJ
        self.aberto = aberto
        self.endereco = endereco
        self.horarioAberto = horarioAberto
        self.horarioFechado = horarioFechado
        self.nome = nome
        self.numero = numero
        self.raioDeEntrega = raioDeEntrega
        self.telefone1 = telefone1
        self.telefonen2 = telefonen2
        
    }
    
    init(dadosJSON:[String:Any]) {
        self.CEP = dadosJSON["CEP"] as? String ?? ""
        self.CNPJ = dadosJSON["CNPJ"] as? String ?? ""
        self.aberto = dadosJSON["aberto"] as? Bool ?? false
        self.endereco = dadosJSON["endereco"] as? String ?? ""
        self.horarioAberto = dadosJSON["horarioAberto"] as? String ?? ""
        self.horarioFechado = dadosJSON["horarioFechado"] as? String ?? ""
        self.nome = dadosJSON["nome"] as? String ?? ""
        self.numero = dadosJSON["numero"] as? String ?? ""
        self.raioDeEntrega = dadosJSON["raioDeEntrega"] as? Int ?? 0
        self.telefone1 = dadosJSON["telefone1"] as? String ?? ""
        self.telefonen2 = dadosJSON["telefonen2"] as? String ?? ""
    }
    
    func toDict(_ dadosAdega:DadosAdega) -> [String:Any]{
        return [
            "CEP":dadosAdega.CEP,
            "CNPJ":dadosAdega.CNPJ,
            "aberto":dadosAdega.aberto,
            "endereco":dadosAdega.endereco,
            "horarioAberto":dadosAdega.horarioAberto,
            "horarioFechado":dadosAdega.horarioFechado,
            "nome":dadosAdega.nome,
            "numero":dadosAdega.numero,
            "raioDeEntrega":dadosAdega.raioDeEntrega,
            "telefone1":dadosAdega.telefone1,
            "telefonen2":dadosAdega.telefonen2
        ]
        
    }
}
