//
//  MapController.swift
//  2340
//
//  Created by Chengkai Yang on 12/3/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase

class MapController: UIViewController {
    
    var ref: DatabaseReference!
    var markers = [GMSMarker]()
    var locations = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getLocations() {
        print(true)
        ref = Database.database().reference().child("loations")
        ref.observe(.childAdded, with: {(snapshot) -> Void in
            let value = snapshot.value as! NSDictionary
            let location = value.object(forKey: "name") as! String
            print(location)
            let latitude = value.object(forKey: "latitude")
            let longtitude = value.object(forKey: "longtitude")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longtitude as! CLLocationDegrees)
            marker.title = location
            self.markers.append(marker)
        })
    }
    
    override func loadView() {
        getLocations()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 33.75416, longitude: -84.37742, zoom: 9.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 33.75416, longitude: -84.37742)
        marker.title = "AFD Station 4"
        marker.snippet = "AFD Station 4"
        marker.map = mapView
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 33.73182, longitude: -84.43971)
        marker1.title = "BOYS & GILRS CLUB W.W. WOOLFOLK"
        marker1.snippet = "BOYS & GILRS CLUB W.W. WOOLFOLK"
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 33.70866, longitude: -84.41853)
        marker2.title = "PATHWAY UPPER ROOM CHRISTIAN MINISTRIES"
        marker2.snippet = "PATHWAY UPPER ROOM CHRISTIAN MINISTRIES"
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 33.80129, longitude: -84.25537)
        marker3.title = "PAVILION OF HOPE INC"
        marker3.snippet = "PAVILION OF HOPE INC"
        marker3.map = mapView
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: 33.71747, longitude: -84.2521)
        marker4.title = "D&D CONVENIENCE STORE"
        marker4.snippet = "D&D CONVENIENCE STORE"
        marker4.map = mapView
        
        let marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2D(latitude: 33.96921, longitude: -84.3688)
        marker5.title = "KEEP NORTH FULTON BEAUTIFUL"
        marker5.snippet = "KEEP NORTH FULTON BEAUTIFUL"
        marker5.map = mapView
    }
}
