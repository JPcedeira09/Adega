//
//  Usuario.swift
//  Adega
//
//  Created by Joao Paulo on 14/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import Foundation

struct Usuario{
    
    var email:String
    var nome:String
    var cpf:String
    var cep:String
    var endereco:String
    var numero:String
    var complemento:String
    var celular:String
    
 init(email:String,nome:String,cpf:String,cep:String,endereco:String,numero:String,complemento:String,celular:String) {
    
        self.email = email
        self.nome = nome
        self.cpf = cpf
        self.cep = cep
        self.endereco = endereco
        self.numero = numero
        self.complemento = complemento
        self.celular = celular
    }
    
    func toDict (_ usuario : Usuario) -> [String:Any]{
        
        return ["nome":usuario.nome,
                "cpf":usuario.cpf,
                "cep":usuario.cep,
                "endereco":usuario.endereco,
                "numero":usuario.numero,
                "complemento":usuario.complemento,
                "celular":usuario.celular,
                "email":usuario.email
        ]
    }
    
    init( usuarioJSON : [String : Any]) {
        
        self.email = usuarioJSON["email"] as? String ?? ""
        self.nome = usuarioJSON["nome"] as? String ?? ""
        self.cpf =  usuarioJSON["cpf"] as? String ?? ""
        self.cep = usuarioJSON["cep"] as? String ?? ""
        self.endereco = usuarioJSON["endereco"] as? String ?? ""
        self.numero = usuarioJSON["numero"] as? String ?? ""
        self.complemento = usuarioJSON["complemento"] as? String ?? ""
        self.celular = usuarioJSON["celular"] as? String ?? ""
    }
    
}
