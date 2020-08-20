//
//  MapViewController.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 20/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

//    var locationManager = CLLocationManager()

    var shops: [ShopModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
//        locationManager.delegate = self

        if let shops = shops {
            for i in 0..<shops.count {
                let shop = shops[i]
                let lat = Double(shop.latitude)
                let lon = Double(shop.longitude)
                let pointAnnotation = MKPointAnnotation()

                    pointAnnotation.title = shop.address
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    mapView.addAnnotation(pointAnnotation)

            }
        }
    }
    

}

extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("mapViewWillStartLoadingMap")
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("mapViewDidFinishLoadingMap")
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }


}
//extension MapViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
////            mapView.showsUserLocation = true
//        }
//    }
//
//}
