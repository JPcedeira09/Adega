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
    var valoresPedidos = [ValoresPedido]()

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
            let count = Int(snapshot.childrenCount)
            print(count)
            var valoresPedidosRetrived = [ValoresPedido]()
            for i in 1...count{
                print("Pedido\(i)")
                
                self.ref.child("Adega").child("Pedidos").child("Pedido\(i)").child("ValoresPedido").observe(.value) { (snapshot) in
                    let child = snapshot as! DataSnapshot
                    let dict = child.value as! NSDictionary
                    let valoresPedido = ValoresPedido(valoresPedidoJSON: dict as! [String : Any])
                    
                    valoresPedidosRetrived.append(valoresPedido)
                    self.valoresPedidos = valoresPedidosRetrived
                    print(self.valoresPedidos)
                    self.table.reloadData()
                    
                }
            }
            self.table.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(valoresPedidos.count)
        return valoresPedidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "PedidosAdegaTableViewCell") as! PedidosAdegaTableViewCell
        
        let valoresPedido = valoresPedidos[indexPath.row]

        cell.hora.text = valoresPedido.dataPedido
        cell.numeroPedido.text = "Pedido\(indexPath.row+1)"
        cell.valorTotal.text = "\(valoresPedido.valorTotalProduto)"
        
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
