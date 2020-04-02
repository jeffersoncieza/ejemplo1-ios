//
//  RegisterController.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/28/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSavePressed(_ sender: UIButton) {
        guard let name = txtName.text else {
            print("Ingrese nombre")
            return
        }
        guard let title = txtTitle.text else {
            print("Ingrese titulo")
            return
        }
        guard let salary = txtSalary.text else {
            print("Ingrese salario")
            return
        }
        
        let dto = PersonDto(name, title, Double(salary)!)
        ApiServiceV2.sharedInstance.createPerson(dto) { (data, urlResponse, error) in
            if let d = data {
                print("Se registro correctamente")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onClosePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
