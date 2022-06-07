//
//  ViewController.swift
//  Finalapp
//
//  Created by Ulises on 2022-05-31.
//

import UIKit
import MapKit
import CoreLocation


class MapasViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate {

    
    
    var manager = CLLocationManager()
    
    @IBOutlet weak var buscar: UISearchBar!
    
    @IBOutlet weak var map: MKMapView!
    
    var latitud: CLLocationDegrees?
    var longitud: CLLocationDegrees?
    
    var altitud : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscar.delegate = self
        map.delegate = self
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func ubicacion(_ sender: UIBarButtonItem) {
    
        let alerta = UIAlertController(title: "Ubiacion", message: "Coordenadas: \(latitud ?? 0) \(longitud ?? 0)", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        
      
        alerta.addAction(aceptar)
        
        
        present(alerta,animated: true)
        
        let localizacion = CLLocationCoordinate2D(latitude: latitud!, longitude: longitud!)
        
        let spanMapa = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: localizacion, span: spanMapa)
            
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
    }
    
    
    func trazarRuta(coordenadasdest: CLLocationCoordinate2D) {
        
        guard let cordorigen = manager.location?.coordinate else {return}
        
        let origenPlacemark = MKPlacemark(coordinate: cordorigen)
        
        let destinoPlacemark = MKPlacemark(coordinate:  coordenadasdest)
        
        let origenitem = MKMapItem(placemark: origenPlacemark)
      
        let destinoItem = MKMapItem(placemark: destinoPlacemark)
        
        let solicitudDestino = MKDirections.Request()
        solicitudDestino.source = origenitem
        solicitudDestino.destination = destinoItem
        
        solicitudDestino.transportType = .automobile
        solicitudDestino.requestsAlternateRoutes = true
        
        let direcciones = MKDirections(request: solicitudDestino)
        direcciones.calculate { respuesta, error in
            
            guard let respuestaS = respuesta else {
                if let error = error {
                    print("Error al calcular la ruta \(error)")
                }
                return
            }
            
            let ruta = respuestaS.routes[0]
            
            self.map.addOverlay(ruta.polyline)
            self.map.setVisibleMapRect(ruta.polyline.boundingMapRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor =  .blue
        return render
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        buscar.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        
        if let direccion = buscar.text {
            geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error: Error?)  in
                
                guard let destinoRut = places?.first?.location else {return}
                
                
                if error == nil {
                    let lugar = places?.first
                    let anotacion = MKPointAnnotation()
                    anotacion.coordinate = (lugar?.location?.coordinate)!
                    anotacion.title = direccion
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                    
                    self.map.setRegion(region, animated: true)
                    self.map.addAnnotation(anotacion)
                    self.map.selectAnnotation(anotacion, animated: true)
                    
                    self.trazarRuta(coordenadasdest: destinoRut.coordinate)
                    
                } else {
                    
                    print("Error al enconrar loc: \(error)")
                }
            }
        }
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let ubicacion = locations.first else {
            return
        }
        
      
        latitud = ubicacion.coordinate.latitude
        longitud = ubicacion.coordinate.longitude
     
        altitud = ubicacion.altitude
        
        
        print("Numero de ubicaciones \(locations.count)")
    }
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let alerta = UIAlertController(title: "Error", message: "Lugar no encontrado no hay ubicacion: \(latitud ?? 0) \(longitud ?? 0)", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        
      
        alerta.addAction(aceptar)
        present(alerta,animated: true)
        
        print("Error a sacar ruta: \(error)")
    }
    
}

