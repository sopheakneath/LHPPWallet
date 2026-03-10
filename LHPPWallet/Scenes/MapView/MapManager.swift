//
//  MapManager.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/3/26.
//



import CoreLocation
import MapKit
internal import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
 
    
    
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
    }
}



// ----------------------------------------




