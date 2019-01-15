//
//  CadastroProdutosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 09/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CadastroProdutosViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    var ref: DatabaseReference!
    
    var user: User!

    @IBOutlet weak var imagemProduto: UIImageView!
    @IBOutlet weak var descricao_text: UITextView!
    @IBOutlet weak var quantidadetxtfield: UITextField!
    @IBOutlet weak var valortxtField: UITextField!
    @IBOutlet weak var nometxtField: UITextField!
    @IBOutlet weak var cadastrarbtn: UIButton!
    
    var produto:Produto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        self.user = Auth.auth().currentUser
        self.descricao_text.text = "Digite a descrição do produto aqui!"
        self.imagemProduto.image = UIImage(named: "image_default")
        self.cadastrarbtn.layer.cornerRadius = 4
        self.quantidadetxtfield.delegate = self
        self.valortxtField.delegate = self
        self.nometxtField.delegate = self
        self.descricao_text.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(InicialViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(InicialViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = -1 * keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func cadastrarAction(_ sender: Any) {
        
        if(validadeTxtField(txtField: self.nometxtField, msg: "Preencha o nome do produto!") == true && validadeTxtView(txtView: self.descricao_text, msg: "Preencha a descrição do produto!") == true &&
            validadeTxtField(txtField: self.quantidadetxtfield, msg: "Preencha a quantidade atual do produto!") == true &&
            validadeTxtField(txtField: self.valortxtField , msg: "Preencha o preço atual do produto!") == true){
            
            let qtd = Int(self.quantidadetxtfield.text!) ?? 0
            produto = Produto(nome: self.nometxtField.text!, descricao: self.descricao_text.text!, quantidade: qtd, valor: Double(self.valortxtField.text!) ?? 0.0, disponivel: validaQTD(quantidade: qtd))
            
            self.ref.child("Adega").child("Produtos").child((produto?.nome)!).setValue(produto?.toDict(produto!))
            print("Produto Cadastrado com sucesso!")
            segueForStoryboard(nameID: "HomeDono")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension CadastroProdutosViewController {

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


