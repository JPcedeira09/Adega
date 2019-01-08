//
//  PedidoDetalheViewController.swift
//  Adega
//
//  Created by Joao Paulo on 07/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class PedidoDetalheViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        self.table.register(UINib(nibName: "PedidoDetalheTableViewCell", bundle: nil), forCellReuseIdentifier: "PedidoDetalheTableViewCell")
    }
}

extension PedidoDetalheViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "PedidoDetalheTableViewCell") as! PedidoDetalheTableViewCell
        
        return cell
    }
    
}
