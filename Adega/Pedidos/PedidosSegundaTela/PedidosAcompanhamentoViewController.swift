//
//  PedidosAcompanhamentoViewController.swift
//  Adega
//
//  Created by Joao Paulo on 18/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PedidosAcompanhamentoViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var ref:DatabaseReference!
    var pedido:Pedido?
    @IBOutlet weak var enderecoNumero: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enderecoNumero.text = "\((pedido?.usuario.endereco)!), \((pedido?.usuario.numero)!)"
        
        self.table.delegate = self
        self.table.dataSource = self
        self.ref = Database.database().reference()
        
        self.table.register(UINib(nibName: "ItensCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "ItensCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "StatusPedidosTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusPedidosTableViewCell")
        self.table.register(UINib(nibName: "FormaPagamentoAdegaTableViewCell", bundle: nil), forCellReuseIdentifier: "FormaPagamentoAdegaTableViewCell")
        self.table.register(UINib(nibName: "ItensCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "ItensCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "TotalPedidosTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalPedidosTableViewCell")
        self.table.register(UINib(nibName: "HeaderCarrinhoTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCarrinhoTableViewCell")
        self.table.register(UINib(nibName: "HeaderBasicoTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBasicoTableViewCell")

        
    }
    
}

extension PedidosAcompanhamentoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 4 + (self.pedido?.itensCarrinho.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print((self.pedido?.itensCarrinho.count)!)
        
        for i in 1...(self.pedido?.itensCarrinho.count)!{
            print(i)
            if indexPath.row == i {
                
            let cell = table.dequeueReusableCell(withIdentifier: "ItensCarrinhoTableViewCell") as! ItensCarrinhoTableViewCell
                
            let indice = indexPath.row - 1
            let itens = (self.pedido?.itensCarrinho)!
            let item = itens[indice]
            cell.quantidadeNome.text = "\(item.qtd) X \(item.nome)"
                
            let valorString = String(format: "%.2f",item.totalItem).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
            cell.valorTotal.text = "R$ \(valorString)"
                return cell
            }
        }
        
        if indexPath.row == 0{
            
            let cell = table.dequeueReusableCell(withIdentifier: "HeaderBasicoTableViewCell") as! HeaderBasicoTableViewCell
            return cell
        
        }else  if indexPath.row == ((self.pedido?.itensCarrinho.count)! + 1){
            let cell = table.dequeueReusableCell(withIdentifier: "TotalPedidosTableViewCell") as! TotalPedidosTableViewCell
            let valorString = String(format: "%.2f",(self.pedido?.valoresPedido.valorTotalProduto)!).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
            cell.total.text = "R$ \(valorString)"
            return cell
            
        }else if indexPath.row == ((self.pedido?.itensCarrinho.count)! + 2){
            
            let cell = table.dequeueReusableCell(withIdentifier: "FormaPagamentoAdegaTableViewCell") as! FormaPagamentoAdegaTableViewCell
            return cell
            
        }else if indexPath.row == ((self.pedido?.itensCarrinho.count)! + 3){
            
            let cell = table.dequeueReusableCell(withIdentifier: "StatusPedidosTableViewCell") as! StatusPedidosTableViewCell
            return cell
            
        }else{
            
            let cell = table.dequeueReusableCell(withIdentifier: "HeaderBasicoTableViewCell") as! HeaderBasicoTableViewCell
            return cell
            
            return cell
        }
        
    }
}
