//
//  TesteZipCodeViewController.swift
//  Adega
//
//  Created by Joao Paulo on 22/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import CoreLocation

class TesteZipCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getLocationFromPostalCode(postalCode: "04209-000")
        getAddressFromLatLon(pdblLatitude: "-23.6573", withLongitude: "-46.5323")
    }
    //Latitude -23.6244963
    //Longitude -46.5610924
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
//        ceo.geocodeAddressString("09540-550") { (placemark, error) in
//            print(placemark)
//        }
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
        })
        
    }
    
    func getLocationFromPostalCode(postalCode : String){
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(postalCode) {
            (placemarks, error) -> Void in
            if error != nil {
                print("diferente de nil!")
                print(placemarks ?? "NADAAA!")
            }
            if let placemark = placemarks?[0] {
                
                if placemark.postalCode == postalCode{
                    // you can get all the details of place here
                    print("\(placemark.locality)")
                    print("\(placemark.country)")
                }
                else{
                    print("Please enter valid zipcode")
                }
            }
        }
    }

}
