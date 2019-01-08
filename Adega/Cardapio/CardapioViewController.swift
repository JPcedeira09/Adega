//
//  CardapioViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class CardapioViewController: UIViewController {

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
    }
    
}

extension CardapioViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = table.dequeueReusableCell(withIdentifier: "CardapioTableViewCell") as! CardapioTableViewCell

        return cell
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
