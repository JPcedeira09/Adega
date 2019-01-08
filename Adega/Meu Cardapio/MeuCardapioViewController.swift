//
//  MeuCardapioViewController.swift
//  Adega
//
//  Created by Joao Paulo on 03/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class MeuCardapioViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBAction func SairAction(_ sender: UIBarButtonItem) {
        print("O Dono da Adega foi logado com sucesso.")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
        self.present(vc!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.register(UINib(nibName: "MeuCardapioTableViewCell", bundle: nil), forCellReuseIdentifier: "MeuCardapioTableViewCell")
    }
    
}

extension MeuCardapioViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "MeuCardapioTableViewCell") as! MeuCardapioTableViewCell
        
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
