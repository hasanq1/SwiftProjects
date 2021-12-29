//
//  ViewController.swift
//  Exercise6_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 10/14/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var companyList = companyStats()
    func showLongPressGestureRecognizer(){
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        
        longPressGestureRecognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }
    @objc func addAnnotation(press: UILongPressGestureRecognizer)
    {
        if press.state == .began{
            let location = press.location(in: mapView)
            let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
            let loc = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            
            CLGeocoder().reverseGeocodeLocation(loc, completionHandler: {(placemark, error) in
                if error != nil {
                    print("Error in Geocoding")
                }
                if let place = placemark?[0] {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = "Long Pressed Location"
                    
                    if place.locality != "" {
                        annotation.subtitle = "Hello!!"
                    }
                    
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                    }
                }
            })
        }
    }
    func showNotifications()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
            didAllow, error in
            if error != nil {
                print("Error in showing notification")
            }
            let content = UNMutableNotificationContent()
            content.title = "Map Notification!"
            content.body = "Passed 5 seconds after map loading"
            
            // set default sound
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "Completed", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        })
    }
    func showCompanyLocation()
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = CLLocationCoordinate2DMake(companyList.hq_latitude, companyList.hq_longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation=true
        
        let loc = CLLocation(latitude: self.companyList.hq_latitude, longitude: self.companyList.hq_longitude)
        
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler: {(placemark, error) in
            if error != nil {
                print("Error in Geocoding")
            }
            if let place = placemark?[0] {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.companyList.company
                
                if place.locality != "" {
                    annotation.subtitle = "\(place.locality!), \(place.administrativeArea!), \(place.country!)"
                }
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showNotifications()
        showCompanyLocation()
        showLongPressGestureRecognizer()
    }

    
}

