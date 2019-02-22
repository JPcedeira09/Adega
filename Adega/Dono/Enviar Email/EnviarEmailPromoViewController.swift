////
////  EnviarEmailPromoViewController.swift
////  Adega
////
////  Created by Joao Paulo on 21/02/19.
////  Copyright © 2019 Joao Paulo. All rights reserved.
////
//
//import UIKit
//import CircularSpinner
//
//class EnviarEmailPromoViewController: UIViewController ,CircularSpinnerDelegate{
//
//    @IBOutlet weak var close: UIButton!
//    @IBOutlet weak var textoExplicativo: UITextView!
//    @IBOutlet weak var header: UITextField!
//    @IBOutlet weak var mensagem: UITextView!
//    @IBOutlet weak var btn: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        btn.layer.cornerRadius = 4
//    }
//
//    @IBAction func dismissView(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func EnviarEmail(_ sender: Any) {
//        CircularSpinner.show(animated: true, showDismissButton: false, delegate: self)
//
//        if(header.text!.characters.count < 1){
//            let alertController = UIAlertController(title: "Atenção!", message: "Digite a objetivo da mensagem deseja enviar", preferredStyle: .alert)
//
//            let defaultAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//
//            self.present(alertController, animated: true, completion: nil)
//
//            CircularSpinner.hide()
//
//        }else if (mensagem.text!.characters.count < 1){
//
//                let alertController = UIAlertController(title: "Enviado!", message: "mensagem sua mensagem foi enviada para nossa base de usuarios", preferredStyle: .alert)
//
//                let defaultAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//            }else{
//
//                let alertController = UIAlertController(title: "Atenção!", message: "Digite a mensagem que deseja nos passar", preferredStyle: .alert)
//
//                let defaultAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//                CircularSpinner.hide()
//
//            }
//    }
//
//
//
//        @IBAction func enviarMensagem(_ sender: UIButton) {
//            CircularSpinner.show(animated: true, showDismissButton: false, delegate: self)
//
//            if(header.text!.characters.count < 1){
//
//                let alertController = UIAlertController(title: "Atenção!", message: "Digite a objetivo da mensagem deseja enviar", preferredStyle: .alert)
//
//                let defaultAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//
//                CircularSpinner.hide()
//
//            }else if (mensagem.text!.characters.count < 1 || textFieldMsg.text! == "Digite aqui sua mensagem."){
//                if(self.TitleAlertNoMSGFeedback != "" && self.DescriptionalertNoMSGFeedback != ""){
//                    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
//                    let alertView = SCLAlertView(appearance: appearance)
//                    alertView.addButton("Fechar", action: {self.dismiss(animated: true)})
//                    alertView.showError(self.TitleAlertNoMSGFeedback, subTitle: self.DescriptionalertNoMSGFeedback)
//
//                }else{
//
//                    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
//                    let alertView = SCLAlertView(appearance: appearance)
//                    alertView.addButton("Fechar", action: {self.dismiss(animated: true)})
//                    alertView.showError("Atenção!", subTitle: "Digite a mensagem que deseja nos passar")
//                }
//
//                CircularSpinner.hide()
//            }else{
//                var feedback = MBFeedback(userId: (MBUser.currentUser?.id)!, subject: txtFieldSubject.text!, message: textFieldMsg.text!
//                    , platform: "IOS", platformVersion: (Bundle.main.releaseVersionNumber)!, appVersion: Bundle.main.releaseVersionNumberPretty, latitude: latitude!, longitude: longitude!)
//                print(feedback.toDict(feedback))
//                self.sendFeedBack(feedback: feedback)
//            }
//        }
//    }
