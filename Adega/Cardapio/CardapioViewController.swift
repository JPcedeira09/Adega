//
//  CardapioViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CardapioViewController: UIViewController {

    var produtos = [Produto]()
    var produto:Produto?
    var ref: DatabaseReference!
    var usuarioFirebase = Auth.auth()
    @IBOutlet weak var table: UITableView!

    @IBAction func logOut(_ sender: UIBarButtonItem) {
        
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
        
        self.table.register(UINib(nibName: "CardapioTableViewCell", bundle: nil), forCellReuseIdentifier: "CardapioTableViewCell")
        
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
                if(produto.disponivel == true){
                    produtosRetrived.append(produto)
                }
            }
            
            self.produtos = produtosRetrived
            self.table.reloadData()
        }
        
        let uid = (usuarioFirebase.currentUser?.uid)!
        print(uid)
        ref.child("Usuarios").child(uid).child("dados_pessoais").observe(.value) { (snapshot) in
            
            let dict = snapshot.value as! NSDictionary
            let usuario = Usuario(usuarioJSON: dict as! [String : Any])
            print(usuario)
        
        }
    }
    
}

extension CardapioViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "CardapioTableViewCell") as! CardapioTableViewCell

        let produto = produtos[indexPath.row]
        
        let valorString = String(format: "%.2f",produto.valor).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        cell.valor.text = "R$ \(valorString)"
        cell.nome_produto.text = produto.nome
        cell.descricao.text = produto.descricao

        return cell    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let produtoselecionado = produtos[row]
        produto = produtoselecionado
        print(produto!)
        performSegue(withIdentifier: "escolhaProduto", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "escolhaProduto"){
        let destination = segue.destination as? ProdutosSelecionaViewController
            
            destination!.produto = produto!
        }
        
//        // Get the index path from the cell that was tapped
//        // Get the Row of the Index Path and set as index
//        let index = indexPath?.row
//        // Get in touch with the DetailViewController
//        let detailViewController = segue.destinationViewController as! DetailViewController
//        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
//        detailViewController.index = index
    }
}
