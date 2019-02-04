//
//  PedidosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase



struct Count{
    var count:Int
    init(count:Int){
        self.count = count
    }
}
class PedidosViewController: UIViewController {

    var ref:DatabaseReference!
    var countPedidos:Count?
    
    @IBOutlet weak var table: UITableView!
    @IBAction func SairAction(_ sender: UIBarButtonItem) {
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.register(UINib(nibName: "PedidosAdegaTableViewCell", bundle: nil), forCellReuseIdentifier: "PedidosAdegaTableViewCell")
        
        count()
//        for i in 1 ... self.countPedidos! {
//            ref.child("Adega").child("Pedidos").child("pedido_\(i)").observe(.value) { (snapshot) in
//                let dict = snapshot.value as! NSDictionary
//               // let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
//                print(dict)
//            }
//        }
        
        /*
         if(countItens! != 0){
         for i in 1 ... countItens! {
         if indexPath.row == i{
         
         let cell = table.dequeueReusableCell(withIdentifier: "ItensCarrinhoTableViewCell") as! ItensCarrinhoTableViewCell
         
         ref.child("Usuarios").child(UID).child("meus_pedidos").child("produto_\(i)").observe(.value) { (snapshot) in
         let dict = snapshot.value as! NSDictionary
         let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
         cell.quantidadeNome.text = "\(item.qtd)X \(item.nome)"
         
         let valorString = String(format: "%.2f",item.totalItem).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
         self.valorTotal + item.totalItem
         
         cell.valorTotal.text = "R$ \(valorString)"
         }
         
         return cell
         }
         */
//        ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in
//            var produtosRetrived = [Pedido]()
//
//            for item in snapshot.children {
//                let child = item as! DataSnapshot
//                let dict = child.value as! NSDictionary
//                let produto = Pedido(pe: dict as! [String : Any])
//                produtosRetrived.append(produto)
//            }
//
//            self.produtos = produtosRetrived
//            self.table.reloadData()
//        }
        
    }
    
    func count(){
        self.ref = Database.database().reference()
        
        ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in
            var count = 0
            count = Int(snapshot.childrenCount)
            self.countPedidos = Count(count: count)
        }
        print((self.countPedidos?.count))
    }
}

extension PedidosViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "PedidosAdegaTableViewCell") as! PedidosAdegaTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
//        let row = indexPath.row
//        let produtoselecionado = produtos[row]
//        produto = produtoselecionado
//        print(produto!)
        performSegue(withIdentifier: "segueDetalhePedido", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "segueDetalhePedido"){
//            let destination = segue.destination as? PedidosAcompanhamentoViewController
//            
//         //   destination!.produto = produto!
//        }
//    }
    
}
