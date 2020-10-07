//
//  MapManager.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 07.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import MapKit

class MapManager {
    
    let locationManager = CLLocationManager()
    
    private let regionInMeters: Double = 2000
    
    
    func setupPlacemark(place: Place, mapView: MKMapView) {
        guard let location = place.location else {return}
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else {return}
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.subtitle = place.type
            
            guard let placemarkLocation = placemark?.location else {return}
            
            annotation.coordinate = placemarkLocation.coordinate
            
            mapView.showAnnotations([annotation], animated: true)
            mapView.selectAnnotation(annotation, animated: true)
            
        }
    }
    
    func checkLocationServices(mapView: MKMapView, segueIdentifier: String, closure: () -> ()) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization(mapView: mapView, incomeSegueIdentifier: segueIdentifier)
            closure()
        } else {
            DispatchQueue.main.async {
                self.showALert(title: "Location services are disabled", message: "You can enable it in Settings")
            }
        }
    }
    
    func checkLocationAuthorization(mapView: MKMapView, incomeSegueIdentifier: String) {
         switch CLLocationManager.authorizationStatus() {
         case .authorizedWhenInUse:
             mapView.showsUserLocation = true
             if incomeSegueIdentifier == "getAddress" { showUserLocation(mapView: mapView) }
             break
         case .denied:
             DispatchQueue.main.async {
                 self.showALert(title: "Your location is not available", message: "Go to Settings to activate it ")
             }
             break
         case .notDetermined:
             locationManager.requestWhenInUseAuthorization()
         case .restricted:
             break
         case .authorizedAlways:
             break
         @unknown default:
             print("New case is available")
         }
     }

    func showUserLocation(mapView: MKMapView) {
        
        if let location = locationManager.location?.coordinate {
                   let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                   
                   mapView.setRegion(region, animated: true)
               }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
    
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    
    
    func showALert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
    }
}
