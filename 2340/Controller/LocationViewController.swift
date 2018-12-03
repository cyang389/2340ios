//
//  LocationViewController.swift
//  2340
//
//  Created by Chengkai Yang on 12/1/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LocationViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var ls = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocations()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ls.count
    }

    
    func getLocations() {
        ref = Database.database().reference().child("locations")
        ref.observe(.childAdded, with: {(snapshot) -> Void in
            let value = snapshot.value as! NSDictionary
            let location = value.object(forKey: "name") as! String
            self.ls.append(location)
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationViewCell", for: indexPath)
        let location = ls[indexPath.row]
        cell.textLabel?.text = location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "viewDetailLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailLocationController
        {
            let vc = segue.destination as? DetailLocationController
            vc?.location = ls[index]
        }
    }
}
