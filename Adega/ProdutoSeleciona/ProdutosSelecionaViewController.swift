//
//  ProdutosSelecionaViewController.swift
//  Adega
//
//  Created by Joao Paulo on 11/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit

class ProdutosSelecionaViewController: UIViewController {

    var produto:Produto?

    @IBOutlet weak var valorTotal: UILabel!
    @IBOutlet weak var quantidadePedido: UILabel!
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var nomeProduto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(produto)
        self.valorTotal.text = "Total R$ \((produto?.valor)!)"
        self.nomeProduto.text = produto?.nome
        self.descricao.text = produto?.descricao
    }
    
    @IBAction func adicionarCarrinho(_ sender: UIButton) {
    }
    
}
