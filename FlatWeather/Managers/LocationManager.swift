//
//  LocationManager.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 08. 11..
//
//  Wraps Core Location to provide location updates with a minimum distance filter.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, LocationService {
    private let manager = CLLocationManager()
    
    var onLocationUpdate: ((Double, Double) -> Void)?
    
    private let minimumDistanceMoved: CLLocationDistance = 2000
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = minimumDistanceMoved
    }
    
    func startUpdatingLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.last else { return }
        let coord = latest.coordinate
        onLocationUpdate?(coord.latitude, coord.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location permission denied or restricted")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}
