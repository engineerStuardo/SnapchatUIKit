//
//  ViewController.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 27/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: Any) {
        if password.text != "" && email.text != "" {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "Password/Email ?")
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if username.text != "" && password.text != "" && email.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { auth, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR")
                } else {
                    let userDictionary = ["email": self.email.text!, "username": self.username.text!] as [String: Any]
                    let fs = Firestore.firestore()
                    fs.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "Username/Password/Email ?")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

