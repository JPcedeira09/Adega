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
    var countItens = 3
    var items = [ItensCarrinho]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.delegate = self
        self.table.dataSource = self
        
        self.table.register(UINib(nibName: "HeaderCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "ItensCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "ItensCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "AdicionarMaisTableViewCell", bundle: nil), forCellReuseIdentifier: "AdicionarMaisTableViewCell")
        self.table.register(UINib(nibName: "TotaisTableViewCell", bundle: nil), forCellReuseIdentifier: "TotaisTableViewCell")
        self.table.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.table.register(UINib(nibName: "PagamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "PagamentoTableViewCell")
        self.table.register(UINib(nibName: "PedidosTableViewCell", bundle: nil), forCellReuseIdentifier: "PedidosTableViewCell")
        
        fazerPedido.layer.cornerRadius = 4
                
        self.ref = Database.database().reference()
        let user = (Auth.auth().currentUser)!

        ref.child("Usuarios").child(user.uid).child("meus_pedidos").observe(.value) { (snapshot) in
            print()
            print(snapshot.children)
            print()
            
            var itensRetrived = [ItensCarrinho]()
            
            for item in snapshot.children {
                
                let child = item as! DataSnapshot
                let dict = child.value as! NSDictionary
                let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
                
                itensRetrived.append(item)
            }
            self.items = itensRetrived
            print(self.items)
            self.countItens = self.items.count
            self.table.reloadData()
        }
    }
    
    @IBAction func FazerPedidoAction(_ sender: Any) {
    }
}

extension CarrinhoViewController : UITableViewDelegate, UITableViewDataSource{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6 + countItens
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    for i in 1 ... countItens {
        if indexPath.row == i{
            let cell = table.dequeueReusableCell(withIdentifier: "ItensCarrinhoTableViewCell") as! ItensCarrinhoTableViewCell
            let item = items[indexPath.row]
            
            cell.quantidadeNome.text = "\(item.qtd)X \(item.nome)"
            cell.valorTotal.text = "R$ \(item.totalItem)"
           // cell.botao
            return cell
        }
    }
    
    if indexPath.row == 0 {
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderCarrinhoTableViewCell") as! HeaderCarrinhoTableViewCell
        
        return cell
        
    }
     else if indexPath.row == (countItens + 2){
        
    let cell = table.dequeueReusableCell(withIdentifier: "AdicionarMaisTableViewCell") as! AdicionarMaisTableViewCell
    return cell
        
    }else if indexPath.row == (countItens + 3){
        
        let cell = table.dequeueReusableCell(withIdentifier: "TotaisTableViewCell") as! TotaisTableViewCell
        return cell
        
    }else if indexPath.row == (countItens + 4){
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        return cell
        
    }else if indexPath.row == (countItens + 5){
        
        let cell = table.dequeueReusableCell(withIdentifier: "PagamentoTableViewCell") as! PagamentoTableViewCell
        return cell
        
    }else{
        
        let cell = table.dequeueReusableCell(withIdentifier: "HeaderCarrinhoTableViewCell") as! HeaderCarrinhoTableViewCell
        
        return cell
    }
    
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
