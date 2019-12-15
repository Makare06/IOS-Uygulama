//
//  Gonder.swift
//  NotDefteri1
//
//  Created by Muhammed Arda Akinci on 9.05.2019.
//  Copyright © 2019 Muhammed Arda Akinci. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Gonder: UIViewController {

    @IBOutlet weak var KullaniciAdiText: UITextField!
    @IBOutlet weak var IcerikText: UITextView!
    @IBOutlet weak var BaslikText: UITextField!
    
    var ref: DatabaseReference!
    var databaseHandle : DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        BaslikText.text = GirisYapildi.NotBaslik
        IcerikText.text = GirisYapildi.NotIcerik
        
    }
    
    @IBAction func GuncelleButton(_ sender: Any) {
        Guncelle()
        var alert = UIAlertView()
        alert.message = "Guncellendi!"
        alert.addButton(withTitle: "Tamam")
        alert.show()
        
    }
    
    @IBAction func GonderButton(_ sender: Any) {
       
        if(isValidEmail(emailID: KullaniciAdiText.text!) == true){
            post();
            var alert = UIAlertView()
            alert.message = "Gonderildi!"
            alert.addButton(withTitle: "Tamam")
            alert.show()
            
        }
        else if (isValidEmail(emailID: KullaniciAdiText.text!) == false) {
            var alert = UIAlertView()
            alert.message = "Gecerli bir e-mail adresi giriniz!"
            alert.addButton(withTitle: "Tamam")
            alert.show()
        }
        
    }
    
    func post(){
        let kullanici = KullaniciAdiText.text
        let baslik = BaslikText.text
        let icerik = IcerikText.text
        
        let post : [String : AnyObject] = ["kullanici" : kullanici as AnyObject,
                                           "baslik" : baslik as AnyObject,
                                           "icerik" : icerik as AnyObject]
        
        
        self.ref.child("Notlar").childByAutoId().setValue(post)
        
    }
    
    func Guncelle(){
        let kullanici = Auth.auth().currentUser?.email
        
        let GuncelData : [String : AnyObject] = ["kullanici" : kullanici as AnyObject,
                                           "baslik" : BaslikText.text as AnyObject,
                                           "icerik" : IcerikText.text as AnyObject]
        
        databaseHandle = ref?.child("Notlar").observe(.childAdded, with: { (DataSnaphot) in
            let not = (DataSnaphot.value as? NSDictionary)?["baslik"]
            let icerik = (DataSnaphot.value as? NSDictionary)?["icerik"]
            let not_kullanici = (DataSnaphot.value as? NSDictionary)?["kullanici"]
            let not_id = (DataSnaphot.key)
            
            if((not_kullanici) as? String == kullanici){
                if  (not as? String) == GirisYapildi.NotBaslik{
                    if (icerik as? String) == GirisYapildi.NotIcerik{
                        self.ref.child("Notlar").child(not_id).setValue(GuncelData)
                    }
                }
            }
            
            
            
        })
    }
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
}
