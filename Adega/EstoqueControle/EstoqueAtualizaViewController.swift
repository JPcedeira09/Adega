//
//  EstoqueAtualizaViewController.swift
//  Adega
//
//  Created by Joao Paulo on 17/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EstoqueAtualizaViewController: UIViewController {

    var produto:Produto?
    var ref = Database.database().reference()
    var imagens:[UIImage]?

    @IBOutlet weak var imagemProduto: UIImageView!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var quantidade: UITextField!
    @IBOutlet weak var valor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(produto!)
        print(imagens?.count)
        self.nome.text = produto?.nome
        self.descricao.text = produto?.descricao
        self.quantidade.text = "\((produto?.quantidade)!)"
        self.valor.text = "\((produto?.valor)!)"
        
    }
    
    @IBAction func Atualizar(_ sender: Any) {
       
        if(validadeTxtField(txtField: self.nome, msg: "Preencha o nome do produto!") == true && validadeTxtView(txtView: self.descricao, msg: "Preencha a descrição do produto!") == true &&
            validadeTxtField(txtField: self.quantidade, msg: "Preencha a quantidade atual do produto!") == true &&
            validadeTxtField(txtField: self.valor , msg: "Preencha o preço atual do produto!") == true){
            
            let qtd = Int(self.quantidade.text!) ?? 0
            produto = Produto(nome: self.nome.text!, descricao: self.descricao.text!, quantidade: qtd, valor: Double(self.valor.text!) ?? 0.0, disponivel: validaQTD(quantidade: qtd))
        ref.self.ref.child("Adega").child("Produtos").child((produto?.nome)!).updateChildValues((produto?.toDict(self.produto!))!)
            print("Produto Atualizado com sucesso!")
            segueForStoryboard(nameID: "HomeDono")
        
        }
        
    }
    
    func validaQTD(quantidade: Int)->Bool {
        if(quantidade > 0)
        {return true}
        else
        {return false}
    }
    
    func validadeTxtField(txtField:UITextField , msg:String) -> Bool{
        if(txtField.text! == ""){
            alertSimples(title: "Campo Invalido", msg: msg)
            return false
        }else{
            return true
        }
    }
    func validadeTxtView(txtView:UITextView , msg:String) -> Bool{
        if(txtView.text! == ""){
            alertSimples(title: "Campo Invalido", msg: msg)
            return false
        }else{
            return true
        }
    }
    
    func alertSimples(title:String , msg:String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func segueForStoryboard(nameID:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: nameID)
        self.present(vc!, animated: true, completion: nil)
    }
}
