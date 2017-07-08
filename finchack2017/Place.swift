//
//  Places.swift
//  MapKit Starter
//
//  Created by Pranjal Satija on 10/25/16.
//  Copyright © 2016 Pranjal Satija. All rights reserved.
//

import MapKit

@objc class Place: NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

    static func getPlaces() -> ([Place],[Place]) {

        guard let path = Bundle.main.path(forResource: "pro0", ofType: "plist"), let array = NSArray(contentsOfFile: path) else { return ([],[]) }

        var places_single = [Place]()
        var places_multi = [Place]()

        for item in array {
            let dictionary = item as? [String : Any]
            let title = dictionary?["title"] as? String
            let subtitle = dictionary?["description"] as? String
            let latitude = dictionary?["latitude"] as? Double ?? 0, longitude = dictionary?["longitude"] as? Double ?? 0

            let place = Place(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2DMake(latitude, longitude))
            if(places_single.count<5){
                places_single.append(place)
            }else{
                places_multi.append(place)
            }
        }

        return (places_single as [Place], places_multi as [Place])
    }
}

extension Place: MKAnnotation { }
