//
//  LoginViewController.swift
//  MyBudget
//
//  Created by Huawei Gao on 2018/12/10.
//  Copyright © 2018 Huawei Gao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func touchLogin(_ sender: Any) {
        if username.text != "admin" {
            showAlertView(text: "username is error")
        }else if password.text != "123456" {
            showAlertView(text: "password is error")
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func showAlertView( text:String) {
        let av = UIAlertController(title: "", message: text as String, preferredStyle: .alert)
        av.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(av, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
