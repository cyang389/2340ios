//
//  DonationsViewController.swift
//  2340
//
//  Created by Chengkai Yang on 12/2/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DonationsViewController: UITableViewController {

    var ref: DatabaseReference!
    var location: String = ""
    var donations = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Donation", style: .done, target: self, action: #selector(tap))
        getDonations()
    }

    func getDonations() {
        location = location.replacingOccurrences(of: ",", with: ".")
        ref = Database.database().reference().child("donations")
        ref.observe(.childAdded, with: {(snapshot) -> Void in
            let value = snapshot.value as! NSDictionary
            let l = value.object(forKey: "location") as! String
            if l == self.location {
                self.donations.append(value.object(forKey: "shortDescription") as! String)
            }
            self.tableView.reloadData()
        })
    }
    
    @objc func tap() {
        performSegue(withIdentifier: "addDonation", sender: self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationViewCell", for: indexPath)
        let donation = donations[indexPath.row]
        cell.textLabel?.text = donation
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "ViewDetailDonation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailDonationController
        {
            let vc = segue.destination as? DetailDonationController
            vc?.donation = donations[index]
        }
        if segue.destination is AddDonationController
        {
            let vc = segue.destination as? AddDonationController
            vc?.location = self.location
        }
    }
}
