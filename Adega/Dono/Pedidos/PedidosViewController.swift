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
    var pedido:Pedido?

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
                    
                    print("-----------------------------")
                    print(snapshot)
                    print("-----------------------------")

                    var pedidosRetrived = [Pedido]()
                    var itensRetrived = [ItensCarrinho]()

                    for pedido in snapshot.children {
                        
                        let child = pedido as! DataSnapshot
                        let dict = child.value as! NSDictionary
                        var pedidoRetriver = Pedido(pedidoJSON: dict as! [String : Any])
                        
                        let itens = child.childSnapshot(forPath: "Itens")
                        for x in itens.children{
                            let y = x as! DataSnapshot
                            let dict2 = y.value as! NSDictionary
                            let itemRetriver = ItensCarrinho(itensCarrinhoJSON: dict2 as! [String : Any])
                            itensRetrived.append(itemRetriver)
                        }
                        
                        pedidoRetriver.itensCarrinho = itensRetrived
                        pedidosRetrived.append(pedidoRetriver)
                    }
                    
                    self.pedidos = pedidosRetrived
                    self.table.reloadData()
                    
                }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "PedidosAdegaTableViewCell") as! PedidosAdegaTableViewCell
        
        let pedido = pedidos[indexPath.row]

        cell.distanciaEntrega.text = "3,5 Km"
        cell.timerPedido.text = pedido.valoresPedido.dataPedido
        cell.nomeEnumeroPedido.text = "#00\(indexPath.row+1) - \(pedido.usuario.nome)"
        
                let valorString = String(format: "%.2f",pedido.valoresPedido.valorTotalProduto).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        cell.valorTotal.text = "R$ \(valorString)"
        cell.statusPedido.text = pedido.valoresPedido.statusPedido

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let produtoselecionado = pedidos[row]
        pedido = produtoselecionado
        performSegue(withIdentifier: "segueDetalhePedido", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueDetalhePedido"){
            let destination = segue.destination as? PedidosAcompanhamentoViewController
            destination!.pedido = pedido!
        }
    }
    
}
