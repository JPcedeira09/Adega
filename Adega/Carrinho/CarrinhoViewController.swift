//  CarrinhoViewController.swift
//  Adega
//
//  Created by Joao Paulo on 07/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CarrinhoViewController: UIViewController {

    var ref:DatabaseReference!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var fazerPedido: UIButton!
    
    var countItens:Int?
    var itens = [ItensCarrinho]()
    var usuarioFirebase = Auth.auth()
    var countPedidos = 0
    var UID = ""
    var usuario:Usuario?

    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.UID = (usuarioFirebase.currentUser?.uid)!
        
        self.table.delegate = self
        self.table.dataSource = self
        fazerPedido.layer.cornerRadius = 4
        
        self.ref = Database.database().reference()
        montaCell()
        var array = [ItensCarrinho]()
        
        for i in 1 ... countItens!{
            ref.child("Usuarios").child(UID).child("meus_pedidos").child("produto_\(i)").observe(.value) { (snapshot) in

                let dict = snapshot.value as! NSDictionary
                let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
                array.append(item)
            }
            self.reloadInputViews()
            self.table.reloadData()
        }
        
        print("Quantidade de itens é:\(self.itens.count)")
        ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in
            self.countPedidos = Int(snapshot.childrenCount)
        }
    }
    
    /*
     static func remove(child: String) {
     
     let ref = self.ref.child(child)
     
     ref.removeValue { error, _ in
     
     print(error)
     }
     */
    func montaCell(){
        
        self.table.register(UINib(nibName: "HeaderCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "ItensCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "ItensCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "AdicionarMaisTableViewCell", bundle: nil), forCellReuseIdentifier: "AdicionarMaisTableViewCell")
        self.table.register(UINib(nibName: "TotaisPagamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "TotaisPagamentoTableViewCell")
        self.table.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.table.register(UINib(nibName: "PagamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "PagamentoTableViewCell")
        self.table.register(UINib(nibName: "PedidosTableViewCell", bundle: nil), forCellReuseIdentifier: "PedidosTableViewCell")
    }
    
    @IBAction func FazerPedidoAction(_ sender: Any) {
        
        ref.child("Usuarios").child(UID).child("valoresPedido").observe(.value) { (snapshot) in
            let dict = snapshot.value as! NSDictionary
            let valores = ValoresPedido(valoresPedidoJSON: dict as! [String : Any])
            self.ref.child("Adega").child("Pedidos").child("pedido_\(self.countPedidos+1)").child("valoresPedido").setValue(valores.toDict(valores))
        }
        
        ref.child("Usuarios").child(UID).child("dados_pessoais").observe(.value) { (snapshot) in
            let dict = snapshot.value as! NSDictionary
            let retornoUsuario = Usuario(usuarioJSON: dict as! [String : Any])
            self.ref.child("Adega").child("Pedidos").child("pedido_\(self.countPedidos+1)").child("dados_cliente").setValue(retornoUsuario.toDict(retornoUsuario))
        }
        
        for i in 1 ... countItens!{
         
        ref.child("Usuarios").child(UID).child("meus_pedidos").child("produto_\(i)").observe(.value) { (snapshot) in
            
            let dict = snapshot.value as! NSDictionary
            self.ref.child("Adega").child("Pedidos").child("pedido_\(self.countPedidos+1)").child("Itens").child("item_\(i)").setValue(dict)

            }
        }
    }
    
}

extension CarrinhoViewController : UITableViewDelegate, UITableViewDataSource{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6 + countItens!
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if(countItens! != 0){
    for i in 1 ... countItens! {
        if indexPath.row == i{
            
            let cell = table.dequeueReusableCell(withIdentifier: "ItensCarrinhoTableViewCell") as! ItensCarrinhoTableViewCell
            
              ref.child("Usuarios").child(UID).child("meus_pedidos").child("produto_\(i)").observe(.value) { (snapshot) in
                let dict = snapshot.value as! NSDictionary
                let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
                cell.quantidadeNome.text = "\(item.qtd)X \(item.nome)"
                
                let valorString = String(format: "%.2f",item.totalItem).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)

                cell.valorTotal.text = "R$ \(valorString)"
                
                cell.botao.addTarget(self, action: Selector("connected:"), for: .touchUpInside)
                cell.botao.tag = indexPath.row

            }
            return cell
        }
        
        }
    }
    
    if indexPath.row == 0 {
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderCarrinhoTableViewCell") as! HeaderCarrinhoTableViewCell
        return cell
        
    }
     else if indexPath.row == (countItens! + 2){
        
    let cell = table.dequeueReusableCell(withIdentifier: "AdicionarMaisTableViewCell") as! AdicionarMaisTableViewCell
    return cell
        
    }else if indexPath.row == (countItens! + 3){

        
        let cell = table.dequeueReusableCell(withIdentifier: "TotaisPagamentoTableViewCell") as! TotaisPagamentoTableViewCell
        
        if(countItens! != 0){
            var total = [Double]()
                ref.child("Usuarios").child(UID).child("valoresPedido").observe(.value) { (snapshot) in
                    let dict = snapshot.value as! NSDictionary
                    let valores = ValoresPedido(valoresPedidoJSON: dict as! [String : Any])
                    
                    let valorString = String(format: "%.2f",valores.valorTotalProduto).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
                    
                    cell.total.text = "R$ \(valorString)"
            }
            
        }
        return cell
        
    }else if indexPath.row == (countItens! + 4){
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        return cell
        
    }else if indexPath.row == (countItens! + 5){
        
        let cell = table.dequeueReusableCell(withIdentifier: "PagamentoTableViewCell") as! PagamentoTableViewCell
        return cell
        
    }else{
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderCarrinhoTableViewCell") as! HeaderCarrinhoTableViewCell
        
        return cell
    }
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let groceryItem = items[indexPath.row]
//            groceryItem.ref?.removeValue()
//        }

    }
}


//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            print("Tela ESTOQUE")
//            performSegue(withIdentifier: "segueEstoque", sender: self)
//        case 1:
//            print("")
//        default:
//            print("DEU RUIM")
//        }
//
//    }


/*
 if indexPath.row == 0 {
 let cell = table.dequeueReusableCell(withIdentifier: "TipoPessoaTableViewCell") as! TipoPessoaTableViewCell
 return cell
 }else if indexPath.row == 1{
 let cell = table.dequeueReusableCell(withIdentifier: "InfoPessoaisTableViewCell") as! InfoPessoaisTableViewCell
 return cell
 }else if indexPath.row == 2{
 let cell = table.dequeueReusableCell(withIdentifier: "InfoFuncionarioTableViewCell") as! InfoFuncionarioTableViewCell
 return cell
 }else if indexPath.row == 3{
 let cell = table.dequeueReusableCell(withIdentifier: "CadastrarBtnTableViewCell") as! CadastrarBtnTableViewCell
 return cell
 }else{
 let cell = table.dequeueReusableCell(withIdentifier: "EstoqueTableViewCell") as! EstoqueTableViewCell
 return cell
 }
 */
