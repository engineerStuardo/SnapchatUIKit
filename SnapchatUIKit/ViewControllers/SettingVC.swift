//
//  SettingVC.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 30/4/23.
//

import UIKit
import FirebaseAuth

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch {
            
        }
    }
    
}
