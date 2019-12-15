//
//  GirisYapildi.swift
//  NotDefteri1
//
//  Created by Muhammed Arda Akinci on 2.05.2019.
//  Copyright © 2019 Muhammed Arda Akinci. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
var myIndex = 0
class GirisYapildi: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dataTableView: UITableView!
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    
    var NotlarData = [String]()
    var NotlarIcerik = [String]()
    
    static var NotBaslik = "null";
    static var NotIcerik = "null";
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addButton.layer.cornerRadius = addButton.frame.height / 2
        
        dataTableView.delegate = self;
        dataTableView.dataSource = self;
        
        ref = Database.database().reference()
        let kullanici = Auth.auth().currentUser?.email
        
        databaseHandle = ref?.child("Notlar").observe(.childAdded, with: { (DataSnaphot) in
            let not = (DataSnaphot.value as? NSDictionary)?["baslik"]
            let icerik = (DataSnaphot.value as? NSDictionary)?["icerik"]
            let not_kullanici = (DataSnaphot.value as? NSDictionary)?["kullanici"]
            
            if((not_kullanici) as? String == kullanici){
                if let actualNot = not{
                    self.NotlarData.append(actualNot as! String)
                    self.dataTableView.reloadData()
                }
                if let actualIcerik = icerik{
                    self.NotlarIcerik.append(actualIcerik as! String)
                    
                }
            }
            
            
            
        })
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aindexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: aindexPath!)! as UITableViewCell
        myIndex = indexPath.row
        
        GirisYapildi.NotBaslik = NotlarData[indexPath.row]
        GirisYapildi.NotIcerik = NotlarIcerik[indexPath.row]
        
        performSegue(withIdentifier: "segue", sender: self)
        
        //let alertController = UIAlertController(title: NotlarData[indexPath.row], message: //NotlarIcerik[indexPath.row], preferredStyle: .alert)
        
        //let defaultAction = UIAlertAction(title: "Kapat", style: .default, handler: nil)
        //let defaultAction1 = UIAlertAction(title: "Gonder", style: .default, handler: nil)
        //let defaultAction2 = UIAlertAction(title: "Guncelle", style: .default, handler: nil)
        
        //alertController.addAction(defaultAction)
        //alertController.addAction(defaultAction1)
        //alertController.addAction(defaultAction2)

        //present(alertController, animated: true , completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotlarData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell")
        cell?.textLabel?.text = NotlarData[indexPath.row]
        
        return cell!
    }
   
}
