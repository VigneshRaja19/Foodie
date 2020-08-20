//
//  MapsViewController.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 20/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    private let locationManager = CLLocationManager()

    var shops: [ShopModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }



}
extension MapsViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        guard status == .authorizedWhenInUse else {
            return
        }

        locationManager.startUpdatingLocation()

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }

    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {

        let geocoder = GMSGeocoder()


        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }

//            let labelHeight = 50
//            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
//                                                bottom: labelHeight, right: 0)

            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}



class GooglePlace {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    init(name: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
    }
}

class MarkerInfoView: UILabel {

}

extension MapsViewController: GMSMapViewDelegate {

//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        return marker
//    }


    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {

//        let placeMarker = marker as! PlaceMarker
//        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 150))
        let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.height - 50, width: 200, height: 50))
        label.backgroundColor = .lightGray
        label.text = "NEwAddress"
        view.addSubview(label)
        return label
//        if let infoView = UIView.viewFromNibName(name: "MarkerInfoView") as? MarkerInfoView
//        {
//            infoView.nameLabel.text = placeMarker.name
//            view.addSubview(infoView!)
//            return view
//        } else {
//            return nil
//        }
//        CLPlacemark
//        guard let placeMarker = marker as? PlaceMarker else {
//            return nil
//        }

//        guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
//            return nil
//        }

//        infoView.nameLabel.text = placeMarker.place.name
//
//        if let photo = placeMarker.place.photo {
//            infoView.placePhoto.image = photo
//        } else {
//            infoView.placePhoto.image = UIImage(named: "generic")
//        }
//
//        return infoView
//        return UILabel(frame: CGRect(x: 20, y: 30, width: 200, height: 50))
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        mapCenterPinImage.fadeOut(0.25)
        return false
    }

    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
}
