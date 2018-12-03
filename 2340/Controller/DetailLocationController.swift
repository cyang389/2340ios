//
//  DetailLocationController.swift
//  2340
//
//  Created by Chengkai Yang on 12/2/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailLocationController: UITableViewController {
    
    var ref: DatabaseReference!
    var detail = [String]()
    var location: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Donation", style: .done, target: self, action: #selector(tap))
        getLocations()
    }

    func getLocations() {
        location = location.replacingOccurrences(of: ".", with: ",")
        ref = Database.database().reference().child("locations").child(location)
        ref.observe(.childAdded, with: {(snapshot) -> Void in
            let key = snapshot.key
            if let value = snapshot.value as? NSNumber {
                let input = key + ": " + value.stringValue
                self.detail.append(input)
            }
            if let value = snapshot.value as? NSString {
                let input = key + ": " + (value as String)
                self.detail.append(input)
            }
            self.tableView.reloadData()
        })
        
    }
    
    @objc func tap() {
        performSegue(withIdentifier: "viewDonation", sender: self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return detail.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailLocationCell", for: indexPath)
        cell.textLabel?.text = detail[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DonationsViewController
        {
            let vc = segue.destination as? DonationsViewController
            vc?.location = location
        }
    }
}
