//
//  MenuClienteViewController.swift
//  Adega
//
//  Created by Joao Paulo on 12/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class MenuClienteViewController: UIViewController {

    var usuario:Usuario?

    override func viewDidLoad() {
        super.viewDidLoad()


        print(usuario!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is MeusDadosViewController {
            let destination = segue.destination as? MeusDadosViewController
            
            destination!.usuario = usuario!
        }
       
    }

}
