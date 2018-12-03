//
//  AddDonationController.swift
//  2340
//
//  Created by Chengkai Yang on 12/2/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddDonationController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var shortField: UITextField!
    @IBOutlet weak var fullField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var typePick: UIPickerView!
    @IBOutlet weak var commentField: UITextField!
    var ref: DatabaseReference!
    var location: String = ""
    var types = ["NOTYPE", "CLOTHING", "HAT", "KITCHEN", "ELECTRONICS",
                 "HOUSEHOLD", "OTHER"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(tap))
        self.typePick.delegate = self
        self.typePick.dataSource = self
    }
    
    @objc func tap() {
        location = location.replacingOccurrences(of: ",", with: ".")
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        let comments = commentField.text
        let fullDescription = fullField.text
        let shortDescription = shortField.text
        let value:Int? = Int(valueField.text!)
        let type = types[typePick.selectedRow(inComponent: 0)]
        
        ref = Database.database().reference().child("donations").child(shortDescription as! String)
        ref.setValue([
            "comments": comments,
            "donationTime": dateString,
            "fullDescription": fullDescription,
            "location": location,
            "shortDescription": shortDescription,
            "type": type,
            "value": value])
        
        performSegue(withIdentifier: "addedDonation", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DonationsViewController
        {
            let vc = segue.destination as? DonationsViewController
            vc?.location = location.replacingOccurrences(of: ".", with: ",")
        }
    }
}
