//
//  InicialViewController.swift
//  Adega
//
//  Created by Joao Paulo on 08/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import CircularSpinner
import GoogleSignIn

class InicialViewController: UIViewController,UITextFieldDelegate{

    //, GIDSignInUIDelegate
    
    @IBOutlet weak var entrabtn: UIButton!
    @IBOutlet weak var cadastrabtn: UIButton!
    @IBOutlet weak var facebookbtn: UIButton!
    @IBOutlet weak var googlebtn: UIButton!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var senha: UITextField!
 
    @IBAction func loginAction(_ sender: AnyObject) {
        CircularSpinner.show("Entrando...", animated: true, type: .indeterminate)
        
        if self.email.text == "" || self.senha.text == "" {
            
            let alertController = UIAlertController(title: "Erro", message: "Por favor, digite seu e-mail e senha.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            CircularSpinner.hide()
            self.present(alertController, animated: true, completion: nil)
            
        }else if self.email.text == "adega.house@gmail.com" && self.senha.text == "adega123"{
            
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.senha.text!) { (user, error) in
                if error == nil {
                    
                    print("O Dono da Adega foi logado com sucesso.")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDono")
                    
                    CircularSpinner.hide()
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    CircularSpinner.hide()
                }
            }
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.senha.text!) { (user, error) in
                if error == nil {
                  
                    print("Voce foi logado com sucesso.")
                    CircularSpinner.hide()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    CircularSpinner.hide()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entrabtn.layer.cornerRadius = 4
        cadastrabtn.layer.cornerRadius = 4
        facebookbtn.layer.cornerRadius = 4
        googlebtn.layer.cornerRadius = 4
        
        self.email.delegate = self
        self.senha.delegate = self
        
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(InicialViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(InicialViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        let data = self.getCurrentDate()
        print("DATA LOCAL:\(data)")
    }
    
    func getCurrentDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date()
        
        let dataFormatada = dateFormatterGet.string(from: date)
        return dataFormatada
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        senha.resignFirstResponder()

        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
