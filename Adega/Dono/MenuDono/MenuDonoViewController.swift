//
//  MenuDonoViewController.swift
//  Adega
//
//  Created by Joao Paulo on 14/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuDonoViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SairAction(_ sender: Any) {
        alertSair()
    }
    
    func alertSair(){
        let alertController = UIAlertController(title: "Logout", message: "Tem certeza que deseja SAIR?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let sairAction = UIAlertAction(title: "Sair", style: .default) { (UIAlertAction) in
            if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true) {
                        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp")
                        
                        appDel.window?.rootViewController = rootController
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(sairAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
