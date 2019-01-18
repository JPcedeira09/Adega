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
    var countItens:Int?
    var ref:DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countItens = 2
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
       
        return 4 + countItens!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(countItens! != 0){
            for i in 1 ... countItens! {
                if indexPath.row == i{
                    let cell = table.dequeueReusableCell(withIdentifier: "ItensCarrinhoTableViewCell") as! ItensCarrinhoTableViewCell
                    
                    
                    return cell
                }
            }
        }
        if indexPath.row == 0{
            
            let cell = table.dequeueReusableCell(withIdentifier: "HeaderBasicoTableViewCell") as! HeaderBasicoTableViewCell
            return cell
        
        }else  if indexPath.row == (countItens! + 1){
            
            let cell = table.dequeueReusableCell(withIdentifier: "TotalPedidosTableViewCell") as! TotalPedidosTableViewCell
            return cell
            
        }else if indexPath.row == (countItens! + 2){
            
            let cell = table.dequeueReusableCell(withIdentifier: "FormaPagamentoAdegaTableViewCell") as! FormaPagamentoAdegaTableViewCell
            return cell
            
        }else if indexPath.row == (countItens! + 3){
            
            let cell = table.dequeueReusableCell(withIdentifier: "StatusPedidosTableViewCell") as! StatusPedidosTableViewCell
            return cell
            
        }else{
            let cell = table.dequeueReusableCell(withIdentifier: "HeaderCarrinhoTableViewCell") as! HeaderCarrinhoTableViewCell
            return cell
        }
        
    }
}
