//
//  ProdutosSelecionaViewController.swift
//  Adega
//
//  Created by Joao Paulo on 11/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProdutosSelecionaViewController: UIViewController {

    var produto:Produto?
    var usuario:Usuario?
    var ref: DatabaseReference!

    @IBOutlet weak var valorTotal: UILabel!
    @IBOutlet weak var quantidadePedido: UILabel!
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var nomeProduto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()

        print(produto!)
        print(usuario!)
        self.valorTotal.text = "Total R$ \((produto?.valor)!)"
        self.nomeProduto.text = produto?.nome
        self.descricao.text = produto?.descricao
        self.quantidadePedido.text = "1"
    }
    
    @IBAction func adicionarCarrinho(_ sender: UIButton) {
       
        let pedido = Pedido(nomeProduto: (produto?.nome)!, quantidadeProduto: Int(self.quantidadePedido.text!)!, valorTotalProduto: Double(self.produto?.valor * Int(self.quantidadePedido.text!)! )!, usuarioComprador: usuario?.toDict(usuario!))
        
        let user = (Auth.auth().currentUser)!
        self.ref.child("Usuarios").child(user.uid).child("meus_pedidos").setValue(self.usuario?.toDict(self.usuario!))
        
    }
    
    @IBAction func reduzirUm(_ sender: Any) {
        if(Int(self.quantidadePedido.text!)! > 1 ){
            self.quantidadePedido.text = "\(Int(self.quantidadePedido.text!)!-1)"
        }
    }
    
    
    @IBAction func adionarMaisUm(_ sender: Any) {
        if( Int(self.quantidadePedido.text!)! < (self.produto?.quantidade)! ){
        self.quantidadePedido.text = "\(Int(self.quantidadePedido.text!)!+1)"
        }
    }
}
