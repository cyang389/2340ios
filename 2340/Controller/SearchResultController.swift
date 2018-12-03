//
//  SearchResultController.swift
//  2340
//
//  Created by Chengkai Yang on 12/2/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SearchResultController: UITableViewController {

    var name: String = ""
    var location: String = ""
    var type: String = ""
    var donations = [String]()
    var page = "search"
    var ref: DatabaseReference!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDonations()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)
        let donation = donations[indexPath.row]
        cell.textLabel?.text = donation
        return cell
    }
    
    func getDonations() {
        ref = Database.database().reference().child("donations")
        ref.observe(.childAdded, with: {(snapshot) -> Void in
            let value = snapshot.value as! NSDictionary
            let shortDescription = value.object(forKey: "shortDescription") as! String
            let l = value.object(forKey: "location") as! String
            let t = value.object(forKey: "type") as! String
            
            if (self.location == "ALL LOCATIONS") {
                if (self.type == "NOTYPE" || self.type == t) {
                    if (self.name.isEmpty || self.name == shortDescription) {
                        self.donations.append(shortDescription)
                    }
                }
            } else {
                if (self.location == l) {
                    if (self.type == "NOTYPE" || self.type == t) {
                        if (self.name.isEmpty || self.name == shortDescription) {
                            self.donations.append(shortDescription)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "searchDetailDonation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailDonationController
        {
            let vc = segue.destination as? DetailDonationController
            vc?.donation = donations[index]
        }
    }
}
