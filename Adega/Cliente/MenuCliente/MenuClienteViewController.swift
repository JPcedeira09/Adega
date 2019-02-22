//
//  MenuClienteViewController.swift
//  Adega
//
//  Created by Joao Paulo on 12/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CircularSpinner

class MenuClienteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func SairAction(_ sender: Any) {
        alertSair()
    }
    
    func alertSair(){
        
        let alertController = UIAlertController(title: "Logout", message: "Tem certeza que deseja sair?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Não", style: .cancel, handler: nil)
        let sairAction = UIAlertAction(title: "Sair", style: .default) { (UIAlertAction) in
            if Auth.auth().currentUser != nil {
                do {
                    CircularSpinner.show("Saindo do aplicativo...", animated: true, type: .indeterminate)

                    try Auth.auth().signOut()
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true) {
                        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp")
                        
                        appDel.window?.rootViewController = rootController
                    }
                    CircularSpinner.hide()
                } catch let error as NSError {
                    print(error.localizedDescription)
                    CircularSpinner.hide()
                }
            }
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(sairAction)
        self.present(alertController, animated: true, completion: nil)
    }
    }

/*
 {
 
 let alert = SCLAlertView()
 
 if(self.alertLogoutTitle == "" || self.alertLogoutDescription == ""){
 alert.addButton("Sair", action: {
 let domain = Bundle.main.bundleIdentifier!
 UserDefaults.standard.removePersistentDomain(forName: domain)
 UserDefaults.standard.synchronize()
 self.dismiss(animated: true) {
 guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
 let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TMLoginViewController")
 appDel.window?.rootViewController = rootController
 }
 })
 alert.showInfo("Sair", subTitle: "Tem certeza que deseja sair?", closeButtonTitle: "Cancelar")
 }else{
 alert.addButton("Sair", action: {
 let domain = Bundle.main.bundleIdentifier!
 UserDefaults.standard.removePersistentDomain(forName: domain)
 UserDefaults.standard.synchronize()
 
 self.dismiss(animated: true) {
 guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
 let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TMLoginViewController")
 appDel.window?.rootViewController = rootController
 }
 })
 alert.showInfo(self.alertLogoutTitle, subTitle: self.alertLogoutDescription, closeButtonTitle: "Cancelar")
 }
 }
 */
