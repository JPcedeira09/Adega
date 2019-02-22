//
//  CadastroInfoViewController.swift
//  Adega
//
//  Created by Joao Paulo on 14/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class CadastroInfoViewController: UIViewController{

    var usuario:Usuario?
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var complemento: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var proximoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proximoBtn.layer.cornerRadius = 4
        usuario = Usuario(email: "", nome: "", cpf: "", cep: "", endereco: "", numero: "", complemento: "", celular: "")
    }
    

    
    @IBAction func ProximoAction(_ sender: Any) {
        if(validadeTxtField(txtField: self.nome, msg: "Você esqueceu de digitar seu nome!") == true
            && validadeTxtField(txtField: self.cpf, msg: "Você esqueceu de digitar seu CPF!") == true
            && validadeTxtField(txtField: self.cep, msg: "Você esqueceu de digitar seu CEP!") == true
            && validadeTxtField(txtField: self.endereco, msg: "Você esqueceu de digitar seu endereço!") == true
            && validadeTxtField(txtField: self.numero, msg: "Você esqueceu de digitar seu numero!") == true
            && validadeTxtField(txtField: self.complemento, msg: "Você esqueceu de digitar seu complemento ou ponto de referencia.") == true
            && validadeTxtField(txtField: self.celular, msg: "Você esqueceu de digitar seu celular!") == true){
            
            self.usuario?.nome = self.nome.text!
            self.usuario?.cpf = self.cpf.text!
            self.usuario?.cep = self.cep.text!
            self.usuario?.endereco = self.endereco.text!
            self.usuario?.numero = self.numero.text!
            self.usuario?.complemento = self.complemento.text!
            self.usuario?.celular = self.celular.text!
            
        performSegue(withIdentifier: "proximoUsuario", sender: nil)
            
        }
    }
    
    func validadeTxtField(txtField:UITextField , msg:String) -> Bool{
        if(txtField.text! == ""){
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "proximoUsuario"){
            let destination = segue.destination as? CadastrarViewController
            
            destination!.usuario = self.usuario!
        }
    }
}

extension CadastroInfoViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(endereco.text != ""){
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nome.resignFirstResponder()
        cpf.resignFirstResponder()
        cep.resignFirstResponder()
        endereco.resignFirstResponder()
        numero.resignFirstResponder()
        complemento.resignFirstResponder()
        celular.resignFirstResponder()

        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        }
        
        nome.resignFirstResponder()
        cpf.resignFirstResponder()
        cep.resignFirstResponder()
        endereco.resignFirstResponder()
        numero.resignFirstResponder()
        complemento.resignFirstResponder()
        celular.resignFirstResponder()

        return false
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
}
