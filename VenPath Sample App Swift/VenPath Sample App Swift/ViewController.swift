//
//  ViewController.swift
//  VenPath Sample App Swift
//
//  Copyright © 2017 VenPath. All rights reserved.
//

import UIKit
import CoreLocation
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestIdPermission()
        initLocationManager()
    }
    
    func requestIdPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Now that we are authorized we can get the IDFA
                    NSLog(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    NSLog("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    NSLog("Not Determined")
                case .restricted:
                    NSLog("Restricted")
                @unknown default:
                    NSLog("Unknown")
                }
            }
        }
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        // This is for requesting location in the foreground and background.  Be sure to turn on the app's capabilities for Background Services -> Location
        locationManager.requestAlwaysAuthorization()
        
        //  This is for requesting foreground location only
        // locationManager.requestWhenInUseAuthorization()

        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            //This allows the app to wake up from a background state when the location of the device has changed
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager!, didFailWithError error: Error!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            print(error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let location = locationArray.lastObject as! CLLocation
        venpath.trackLocation(location)
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager!,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        var locationStatus: NSString
        
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    func sendEmailToVenPath(email: String) {
        venpath.track(["email":"newemail@test.com", "new_user":"true"])
    }
    
    func sendAppUsageToVenPath(email: String) {
        let date = NSDate()
        let timestamp = Int64(date.timeIntervalSince1970 * 1000.0)
        
        venpath.track([
            "app_name": "Test App",
            "event_date": timestamp,
            "event_type": "launch",
            "seconds_used": "100",
            "permissions": "comma,delimited,list"
            ]);
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

