//
//  ViewController.swift
//  MapKit Starter
//
//  Created by Pranjal Satija on 10/25/16.
//  Copyright © 2016 Pranjal Satija. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource

{
    @IBOutlet var mapView: MKMapView?

    var imageArray = [Any]()

    var imageArray0 = [UIImage(named: "Group 73"), UIImage(named: "Group 72"), UIImage(named: "Group 65"), UIImage(named: "Group 88"), UIImage(named: "Group 63")]

    var imageArray1 = [UIImage(named: "Group 63"), UIImage(named: "Group 67"), UIImage(named: "Group 66"), UIImage(named: "Group 89"), UIImage(named: "Group 99")]

    var path1 = false

    let locationManager = CLLocationManager()
    
    var places = [Place]()
    var places_single = [Place]()
    var places_multi = [Place]()

    override func viewDidLoad() {
        //requestLocationAccess()

        (places_single , places_multi) = Place.getPlaces()
        if !path1{
            places = places_multi
            imageArray = imageArray1
            print("path1 detected")
        } else{
            places = places_single
            imageArray = imageArray0
            print("path0 detected")
        }

        //Show the map
//        if CLLocationManager.locationServicesEnabled(){
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            //locationManager.requestAlwaysAuthorization()
//            //locationManager.startUpdatingLocation()
//            
//        }

        let lat = (path1 ? 22.2832221:22.2807481)
        let lng = (path1 ? 114.181369:114.181085)
        let span = MKCoordinateSpanMake(0.014, 0.014)
        let coordinates = CLLocationCoordinate2DMake(lat, lng)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView?.setRegion(region, animated: true)

        addAnnotations()
        addPolyline()
        //addPolygon()
        
        
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(places)
        
        //let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        //mapView?.addOverlays(overlays)
        
        // Add polylines
        
        //        var locations = places.map { $0.coordinate }
        //        print("Number of locations: \(locations.count)")
        //        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        //        mapView?.add(polyline)
        
    }
    
    func addPolyline() {
        var locations = places.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        
        mapView?.add(polyline)
    }
    
    //    func addPolygon() {
    //        var locations = places.map { $0.coordinate }
    //        let polygon = MKPolygon(coordinates: &locations, count: locations.count)
    //        mapView?.add(polygon)
    //    }
}

extension Map2ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "hang_sang_pin")
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

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        return
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell

        cell.image.image = imageArray[indexPath.row] as! UIImage

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailController"{
            //let controller = segue.destination as! pageViewController
            //controller.meal = self.meals[(menuCell.indexPathForSelectedRow?.row)!]
        }
    }
}

extension Map2ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView?.setRegion(region, animated: true)
        
    }
}

