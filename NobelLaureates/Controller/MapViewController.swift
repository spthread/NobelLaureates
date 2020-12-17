
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    @IBOutlet weak private var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    var latestLocation: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        requestLocationPermission()
        addLocationPickerGestures()
    }
    
    private func addLocationPickerGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickedOnMap(gesture:)))
        tap.delegate = self
        mapView.addGestureRecognizer(tap)
    }
    
    @objc func clickedOnMap(gesture: UITapGestureRecognizer) {
        let lCord = mapView.convert(gesture.location(in: mapView), toCoordinateFrom: mapView)
        latestLocation = CLLocation(latitude: lCord.latitude, longitude: lCord.longitude)
        mapView.addAnnotationOnLocation(pointedCoordinate: lCord)
    }
    
    private func requestLocationPermission() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        else if locationManager.authorizationStatus == .authorizedAlways ||
                    locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        // Initialize to defaule location.
        let locCordinate = mapView.convert(mapView.center, toCoordinateFrom: mapView)
        latestLocation = CLLocation(latitude: locCordinate.latitude, longitude: locCordinate.longitude)
        sendLocationDetails()
        mapView.addAnnotationOnLocation(pointedCoordinate: latestLocation!.coordinate)
    }
    
    @IBAction func done(sender: Any) {
        sendLocationDetails()
        locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func sendLocationDetails() {
        guard let pController = presentationController, let presentingVC = pController.presentingViewController as? ReceiveLocationDetails else {
            return
        }
        presentingVC.latestLocation(lat: latestLocation!.coordinate.latitude, long: latestLocation!.coordinate.longitude)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = manager.location
        sendLocationDetails()
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
}


private extension MKMapView {
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointedCoordinate
        annotation.title = "\(pointedCoordinate.latitude), \(pointedCoordinate.longitude)"//"Your selection"
//        annotation.subtitle = "\(pointedCoordinate.latitude), \(pointedCoordinate.longitude)"
        self.setCenter(pointedCoordinate, animated: true)
        self.removeAnnotations(self.annotations)
        self.addAnnotation(annotation)
    }
}
