//
//  NotEkleme.swift
//  NotDefteri1
//
//  Created by Muhammed Arda Akinci on 6.05.2019.
//  Copyright © 2019 Muhammed Arda Akinci. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class NotEkleme: UIViewController{
    var ref: DatabaseReference!
    
    @IBOutlet weak var NotBaslik: UITextField!
    @IBOutlet weak var NotIcerik: UITextField!
    
    @IBOutlet weak var NootIcerik: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
    
}
    
        
    @IBAction func Kaydet(_ sender: Any) {
        post()
    }
    
    func post(){
        let kullanici = Auth.auth().currentUser?.email
        let baslik = NotBaslik.text
        let icerik = NootIcerik.text
            
        let post : [String : AnyObject] = ["kullanici" : kullanici as AnyObject,
                                           "baslik" : baslik as AnyObject,
                                           "icerik" : icerik as AnyObject]
            
            
        self.ref.child("Notlar").childByAutoId().setValue(post)
        
    }
}


