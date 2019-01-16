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

    var item:ItensCarrinho?
    var produto:Produto?
    var usuario:Usuario?
    var ref: DatabaseReference!
    var usuarioFirebase = Auth.auth()
    var countProduto = 0
    
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
        
        let uid = (usuarioFirebase.currentUser?.uid)!
        ref.child("Usuarios").child(uid).child("meus_pedidos").observe(.value) { (snapshot) in
            
            self.countProduto = Int(snapshot.childrenCount)
            print("Count children =\(snapshot.childrenCount)")
        }
    }
    
    @IBAction func adicionarCarrinho(_ sender: UIButton) {
       
        let qtd = Double(self.quantidadePedido.text!)!
//        let pedido = Pedido(nomeProduto: (produto?.nome)!, quantidadeProduto: Int(self.quantidadePedido.text!)!, valorTotalProduto: Double((self.produto?.valor)! * qtd), usuarioComprador: (usuario?.toDict(usuario!))!)
        
        let item = ItensCarrinho(qtd: Int(self.quantidadePedido.text!)!, nome: (produto?.nome)!, totalItem: Double((self.produto?.valor)! * qtd))
        
        let user = (Auth.auth().currentUser)!
        self.ref.child("Usuarios").child(user.uid).child("meus_pedidos").child("produto_\(countProduto+1)").setValue(item.toDict(item))
        performSegue(withIdentifier: "adicionouItemCarrinho", sender: nil)

    }
    
    @IBAction func reduzirUm(_ sender: Any) {
        if(Int(self.quantidadePedido.text!)! > 1 ){
            self.quantidadePedido.text = "\(Int(self.quantidadePedido.text!)!-1)"
            atualizaValorTotal()
        }
    }
    
    @IBAction func adionarMaisUm(_ sender: Any) {
        if( Int(self.quantidadePedido.text!)! < (self.produto?.quantidade)! ){
        self.quantidadePedido.text = "\(Int(self.quantidadePedido.text!)!+1)"
        atualizaValorTotal()
        }
    }
    
    func atualizaValorTotal(){
        let qtd = Double(self.quantidadePedido.text!)!
        self.valorTotal.text = "Total R$ \(Double((self.produto?.valor)! * qtd))"
    }
}
