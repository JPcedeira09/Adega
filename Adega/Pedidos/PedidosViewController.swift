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
    var countPedidos:Int?
    var itens = [ItensCarrinho]()

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
        
        self.ref = Database.database().reference()
        
        ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in

            print(snapshot.children)
            print("Count children = \(snapshot.childrenCount)")
            if(Int(snapshot.childrenCount) == 0){
                self.countPedidos = 0
            }else{
                self.countPedidos = Int(snapshot.childrenCount)
            }
            
            print("Count Pedidos:\((self.countPedidos)!)")
            var countItens = 0
            if(self.countPedidos! != 0 && self.countPedidos! != nil ){
            for i in 1 ... self.countPedidos! {
                self.ref.child("Adega").child("Pedidos").child("Pedido\(i)").observe(.value) { (snapshot) in
                    
                    if(Int(snapshot.childrenCount) == 0){
                        countItens = 0
                    }else{
                        countItens = Int(snapshot.childrenCount)
                    }
                    var itensRetrived = [ItensCarrinho]()
                    print("Count Itens:\(countItens)")
                    for item in snapshot.children {
                        let child = item as! DataSnapshot
                        let dict = child.value as! NSDictionary
                        let item = ItensCarrinho(itensCarrinhoJSON: dict as! [String : Any])
                            itensRetrived.append(item)
                        print(item)
                    }
                    self.itens = itensRetrived
                    self.table.reloadData()
                }
            }
        }
        }
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
