//
//  DeviceLocationService.swift
//  Weather
//
//  Created by Даниял on 26.10.2022.
//

import Combine
import CoreLocation

class DeviceLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    var coordinatesPublisher = PassthroughSubject<CLLocation, Error>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()
    
    private override init() {
        super.init()
    }
    
    static let shared = DeviceLocationService()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.delegate = self
        return manager
    }()

    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            manager.stopUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinatesPublisher.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordinatesPublisher.send(completion: .failure(error))
    }
    
    func convertToCityName(location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "en_en")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("*** Error in \(#function): placemark is nil")
                return
            }
            
            print(location.coordinate.longitude)
            print(location.coordinate.latitude)
            completion(placemark.locality ?? "")
        }
    }
}
