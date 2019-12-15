//
//  ViewController.swift
//  NotDefteri1
//
//  Created by Muhammed Arda Akinci on 2.05.2019.
//  Copyright © 2019 Muhammed Arda Akinci. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func KullaniciOlustur(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Basarili!")
            })
        }
    }
    
    @IBAction func KullaniciGiris(_ sender: Any) {
         if let email = emailText.text, let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user,error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Basarili!")
                self.presentLoggedInScreen()
            })
        }
    }
    func presentLoggedInScreen(){
        let storyboard: UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
        let girisYapildi: GirisYapildi = storyboard.instantiateViewController(withIdentifier: "GirisYapildi") as! GirisYapildi
        self.present(girisYapildi, animated: true, completion: nil)
        
    }
}

