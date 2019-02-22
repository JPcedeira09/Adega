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
import CircularSpinner

class CardapioViewController: UIViewController {

    var produtos = [Produto]()
    var produto:Produto?
    var usuario = Usuario(email: "", nome: "", cpf: "", cep: "", endereco: "", numero: "", complemento: "", celular: "")
    
    var ref: DatabaseReference!
    var usuarioFirebase = Auth.auth()
    var countItens:Int?
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func segueCarrinho(_ sender: Any) {
        CircularSpinner.show("Carregando o carrinho...", animated: true, type: .indeterminate)

        let uid = (usuarioFirebase.currentUser?.uid)!
        self.ref = Database.database().reference()
        
        ref.child("Usuarios").child(uid).child("MeusPedidos").observe(.value) { (snapshot) in
            
            if(Int(snapshot.childrenCount) > 0 || (self.countItens)! > 0){
                print("--------------- O COUNT É:\(snapshot.childrenCount)---------------")
                CircularSpinner.hide()
                self.performSegue(withIdentifier: "carrinho", sender: nil)
            }else{
                CircularSpinner.hide()
                self.alertSimples(title:"Carrinho Vazio",msg: "Escolha algum produto e adicione ele ao seu carrinho.")
            }
        }
    }
    
    
    func alertSimples(title:String , msg:String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        
        self.table.register(UINib(nibName: "CardapioTableViewCell", bundle: nil), forCellReuseIdentifier: "CardapioTableViewCell")
        
        loadInfoFromFirebase()

    }
    
    func loadInfoFromFirebase(){
        self.ref = Database.database().reference()

        do {
     
        CircularSpinner.show("Carregando o cardápio...", animated: true, type: .indeterminate)

               try ref.child("Adega").child("Produtos").observe(.value) { (snapshot) in
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
                ref.child("Usuarios").child(uid).child("DadosPessoais").observe(.value) { (snapshot) in
                    let dict = snapshot.value as! NSDictionary
                    let retornoUsuario = Usuario(usuarioJSON: dict as! [String : Any])
                    self.usuario = retornoUsuario
                }
            
                ref.child("Usuarios").child(uid).child("MeusPedidos").observe(.value) { (snapshot) in
                    
                    print(snapshot.children)
                    print("Count children =\(snapshot.childrenCount)")
                    if(Int(snapshot.childrenCount) == 0){
                        self.countItens = 0
                    }else{
                        self.countItens = Int(snapshot.childrenCount)
                    }
                }
                CircularSpinner.hide()
        } catch  {
                CircularSpinner.hide()
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
        let islandRef = Storage.storage().reference().child("produtos/"+produto.nome+".jpg")
        var imageFIR:UIImage?
        // Download in memory with a maximum allowed size of 1MB (1 * 3000 * 3000 bytes)
        islandRef.getData(maxSize: 1 * 3000 * 3000) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                imageFIR = UIImage(data: data!)
            }
            cell.imagem.image = imageFIR
        }
        
        return cell
        
    }
    
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
            destination!.usuario = usuario
        }
        
        if (segue.identifier == "carrinho" ){
            let destination = segue.destination as? CarrinhoViewController
            
            destination!.countItens = countItens!
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
