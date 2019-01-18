//
//  PedidosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class PedidosViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    //var
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
