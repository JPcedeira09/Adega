//
//  CadastroProdutosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 09/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CadastroProdutosViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var ref: DatabaseReference!
    let storage = Storage.storage()
    var imagePicker = UIImagePickerController()
    var user: User!

    @IBOutlet weak var imagemProduto: UIImageView!
    @IBOutlet weak var descricao_text: UITextView!
    @IBOutlet weak var quantidadetxtfield: UITextField!
    @IBOutlet weak var valortxtField: UITextField!
    @IBOutlet weak var nometxtField: UITextField!
    @IBOutlet weak var cadastrarbtn: UIButton!
    
    var produto:Produto?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
           
            imagemProduto.image = image

        } else{
            print("Algo Esta errado")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
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
            
            var data = Data()
            data = UIImageJPEGRepresentation(imagemProduto.image!, 0.6)!
            let imageRef = Storage.storage().reference().child("produtos/"+(produto?.nome)!+".jpg")
            _ = imageRef.putData(data, metadata: nil)
            
            print("Produto Cadastrado com sucesso!")
            segueForStoryboard(nameID: "HomeDono")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func imageGet(_ sender: UIButton) {
        let alert = UIAlertController(title: "Opções", message: "Por favor, escolha a opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Escolha a Foto", style: .default , handler:{ (UIAlertAction)in

            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else {
                self.alertSimples(title: "Erro", msg: "Biblioteca de Fotos não está habilitada, vá em configurações e habilite-a.")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Tire um Foto", style: .default , handler:{ (UIAlertAction)in

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else {
                self.alertSimples(title: "Erro", msg: "Camera não está habilitada, vá em configurações e habilite-a.")
            }

        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func uploadProfileImage(imageData: Data){
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        let profileImageRef = storageReference.child("users").child(currentUser!.uid).child("\(currentUser!.uid)-profileImage.jpg")
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            } else {
                
                self.imagemProduto.image = UIImage(data: imageData)
                
                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
            }
        }
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


