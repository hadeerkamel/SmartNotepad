//
//  LocationManager.swift
//  SmartNotepad
//
//  Created by Hadeer Kamel on 6/19/21.
//

import UIKit
import CoreLocation

struct LocationData{
    var lat: Double
    var lon: Double
    var address: String

    var location: CLLocation {
        return CLLocation(latitude: self.lat, longitude: self.lon)
    }

    func distance(to location: CLLocation) -> CLLocationDistance {
            return location.distance(from: self.location)
    }
}
protocol LocationManagerDelegate {
    func userAddressUpdated(data: LocationData)
    func alertToOpenSettings()
}
class LocationManager: NSObject, CLLocationManagerDelegate{

    private var locationManager: CLLocationManager?
    private var checkLocationAuthStatusChange = false
    private var delegate: LocationManagerDelegate?

    var currentLocation: CLLocation?{
        get{
           return locationManager?.location
        }
    }
    
    init(delegate: LocationManagerDelegate?){
        self.delegate = delegate
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    func detectUserAddress(){

        requestAuthrization()

        if locationServiceAllowed() {
            getUserAddress()
        }else{
            delegate?.alertToOpenSettings()
        }
    }
    func requestAuthrization(){
        locationManager?.requestWhenInUseAuthorization()
        checkLocationAuthStatusChange = true
    }
    func locationServiceAllowed() -> Bool{
        return CLLocationManager.authorizationStatus() != .denied
    }

    //MARK: Private Functions

    private func getUserAddress(){
        guard let lat = locationManager?.location?.coordinate.latitude else{return}
        guard let lon = locationManager?.location?.coordinate.longitude else{return}
        getAddressFromLatLon(lat: lat, withLongitude: lon)
    }

    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if checkLocationAuthStatusChange{
            if status == .denied {
                delegate?.alertToOpenSettings()
                checkLocationAuthStatusChange = false
            }
            else{
                getUserAddress()
            }
        }
    }

    private func getAddressFromLatLon(lat: Double, withLongitude lon: Double){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]

                                        if pm.count > 0 {
                                            let pm = placemarks![0]

                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }

                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country!
                                            }

                                            self.delegate?.userAddressUpdated(data:  LocationData(lat: lat, lon: lon, address: addressString))

                                        }
                                    })

    }
}
