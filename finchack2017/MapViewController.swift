//
//  MapViewController.swift
//  Plusll
//
//  Created by Marcus Man on 27/5/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let places = Place.getPlaces()
    @IBAction func showbutton(_ sender: Any) {
        //Defining destination
        let latitude:CLLocationDegrees = 22.261556
        let longitude:CLLocationDegrees = 114.129134
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let coordinates2 = CLLocationCoordinate2DMake(22.2620876, 114.1290134)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let placemark2 = MKPlacemark(coordinate: coordinates2)
        
        let mapItem = MKMapItem(placemark: placemark)
        let mapItem2 = MKMapItem(placemark: placemark2)
        
        mapItem.name = "pin1"
        mapItem2.name = "pin2"
        
        mapItem2.openInMaps(launchOptions: options)
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBOutlet weak var testbutton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        
        //Add pin point
        
//        let sourcelocation = CLLocationCoordinate2DMake(22.2620876, 114.1290134)
//        let destlocation = CLLocationCoordinate2DMake(22.261548, 114.1291682)
        
        
//        map.setRegion(MKCoordinateRegionMakeWithDistance(sourcelocation,1500, 1500), animated: true)
        
        //let pin = PinAnnotation(title: "Testing 1", subtitle: "Hello World Baby", coordinate:sourcelocation)
        
        //let pin2 = PinAnnotation(title: "Testing 2", subtitle: "Hello World Baby 2", coordinate:destlocation)
        
        
        //addAnnotations()
        //addPolyline()
        
//        map.addAnnotation(pin)
//        map.addAnnotation(pin2)
//        
        
        //Show the map
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            self.map.showsUserLocation = true
        }
        
    }
    func addAnnotations() {
        map?.delegate = self
        map?.addAnnotations(places)
        
        
        // Add polylines
        
        //        var locations = places.map { $0.coordinate }
        //        print("Number of locations: \(locations.count)")
        //        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        //        mapView?.add(polyline)
        
    }
    
    func addPolyline() {
        var locations = places.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        
        map?.add(polyline)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "place icon")
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView.canShowCallout = true
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
            
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Place, let title = annotation.title else { return }
        
        let alertController = UIAlertController(title: "Welcome to \(title)", message: "You've selected \(title)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    

}



extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.map.setRegion(region, animated: true)
        
    }
}
