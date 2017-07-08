//
//  ViewController.swift
//  nav
//
//  Created by Sebastian Hette on 31.01.2017.
//  Copyright © 2017 MAGNUMIUM. All rights reserved.
//

import UIKit
import MapKit

class testViewController: UIViewController {
    
    @IBAction func showMeWhere(_ sender: Any)
    {
        //Defining destination
        let latitude:CLLocationDegrees = 22.261556
        let longitude:CLLocationDegrees = 114.129134
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "pin point 1"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

