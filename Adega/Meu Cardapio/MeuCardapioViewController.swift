//
//  MeuCardapioViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MeuCardapioViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    var produtos = [Produto]()
    var produto:Produto?

    let imagePicker = UIImagePickerController()

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
        
        self.table.register(UINib(nibName: "MeuCardapioTableViewCell", bundle: nil), forCellReuseIdentifier: "MeuCardapioTableViewCell")
        
        self.ref = Database.database().reference()

        ref.child("Adega").child("Produtos").observe(.value) { (snapshot) in
            print()
            print(snapshot.children)
            print()
            var produtosRetrived = [Produto]()

            for item in snapshot.children {
                let child = item as! DataSnapshot
                let dict = child.value as! NSDictionary
                let produto = Produto(produtoJSON: dict as! [String : Any])
                produtosRetrived.append(produto)
            }
            
            self.produtos = produtosRetrived
            self.table.reloadData()
        }
    }
    
}

extension MeuCardapioViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "MeuCardapioTableViewCell") as! MeuCardapioTableViewCell
        
        let produto = produtos[indexPath.row]
        
        var valorString = String(format: "%.2f",produto.valor).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)

        cell.valorProduto.text = "R$ \(valorString)"

        cell.nome_produto.text = produto.nome
        if(produto.disponivel == true){
            cell.disponibilidade.text = "Disponivel"
        }else{
            cell.disponibilidade.text = "Indisponivel"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let produtoselecionado = produtos[row]
        produto = produtoselecionado
        print(produto!)
        performSegue(withIdentifier: "atualizaEstoque", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "atualizaEstoque"){
            let destination = segue.destination as? EstoqueAtualizaViewController
            
            destination!.produto = produto!
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
}
