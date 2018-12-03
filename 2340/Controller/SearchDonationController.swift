//
//  SearchDonationController.swift
//  2340
//
//  Created by Chengkai Yang on 12/2/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit

class SearchDonationController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var types = ["NOTYPE", "CLOTHING", "HAT", "KITCHEN", "ELECTRONICS",
                 "HOUSEHOLD", "OTHER"]
    var locations = ["ALL LOCATIONS", "AFD Station 4", "BOYS & GILRS CLUB W.W. WOOLFOLK", "PATHWAY UPPER ROOM CHRISTIAN MINISTRIES", "PAVILION OF HOPE INC", "D&D CONVENIENCE STORE", "KEEP NORTH FULTON BEAUTIFUL"]
    var name: String = ""
    var location: String = ""
    var type: String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return types.count
        } else {
            return locations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return types[row]
        } else {
            return locations[row]
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(tap))
        self.typePicker.delegate = self
        self.typePicker.dataSource = self
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
    }
    
    @objc func tap() {
        performSegue(withIdentifier: "searchDonation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SearchResultController
        {
            let vc = segue.destination as? SearchResultController
            vc?.name = nameField.text as! String
            vc?.location = locations[locationPicker.selectedRow(inComponent: 0)]
            vc?.type = types[typePicker.selectedRow(inComponent: 0)]
        }
    }
}
