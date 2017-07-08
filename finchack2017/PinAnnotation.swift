//
//  PinAnnotation.swift
//  Plusll
//
//  Created by Marcus Man on 27/5/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import MapKit

class PinAnnotation: NSObject, MKAnnotation{
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
