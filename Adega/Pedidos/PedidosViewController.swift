//
//  PedidosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PedidosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var ref:DatabaseReference!
    var countPedidos = 0
    var pedidos = [Pedido]()

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

                self.ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in
                    
                    var pedidosRetrived = [Pedido]()

                    for pedido in snapshot.children {
                        let child = pedido as! DataSnapshot
                        let dict = child.value as! NSDictionary
                        let pedidoRetriver = Pedido(pedidoJSON: dict as! [String : Any])
                        pedidosRetrived.append(pedidoRetriver)
                    }
                    
                    self.pedidos = pedidosRetrived
                    self.table.reloadData()
                    
                }
        
//        ref.child("Adega").child("Pedidos").observe(.value) { (snapshot) in
//            let count = Int(snapshot.childrenCount)
//            print(count)
//            var pedidosRetrived = [Pedido]()
//            for i in 1...count{
//                print("Pedido\(i)")
//
//                self.ref.child("Adega").child("Pedidos").child("Pedido\(i)").observe(.value) { (snapshot) in
//                    let child = snapshot as! DataSnapshot
//                    let dict = child.value as! NSDictionary
//                    let pedido = Pedido(pedidoJSON: dict as! [String : Any])
//
//                    pedidosRetrived.append(pedido)
//                    self.pedidos = pedidosRetrived
//                    self.table.reloadData()
//
//                }
//            }
//            self.table.reloadData()
//        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "PedidosAdegaTableViewCell") as! PedidosAdegaTableViewCell
        
        var pedido = pedidos[indexPath.row]

        cell.distanciaEntrega.text = "3,5 Km"
        cell.timerPedido.text = pedido.valoresPedido.dataPedido
        cell.nomeEnumeroPedido.text = "#00\(indexPath.row+1) - \(pedido.usuario.nome)"
        cell.valorTotal.text = "\(pedido.valoresPedido.valorTotalProduto)"
        cell.statusPedido.text = pedido.valoresPedido.statusPedido
        //adega.house@gmail.com
        //adega123
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
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
