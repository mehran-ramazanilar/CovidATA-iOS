//
//  MapView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var countriesData: [CountryDataModel]
    @Binding var selectedPin: CountryAnnotation?
    @Binding var isMapSetUp: Bool?
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        // 1
        view.mapType = MKMapType.standard // (satellite)

        // 2
        let coordinate = CLLocationCoordinate2D(
            latitude: 38, longitude: 25)
        let span = MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120)
        

        // 3
        let annotationData = createAnnotationsFromJson()
        view.delegate = context.coordinator
        view.addAnnotations(annotationData)
        
        if (selectedPin != nil) {
            view.selectAnnotation(selectedPin!, animated: false)
            let region = MKCoordinateRegion(center: selectedPin!.coordinate, span: span)
            view.setRegion(region, animated: true)
        } else {
            if (isMapSetUp == false || isMapSetUp == nil) {
                let region = MKCoordinateRegion(center: coordinate, span: span)
                view.setRegion(region, animated: true)
            }
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator{
        MapViewCoordinator(self, selectedPin: $selectedPin, isMapSetup: $isMapSetUp)
    }
    
    func createAnnotationsFromJson() -> [CountryAnnotation] {
        let countries = countriesData
        var annotations: [CountryAnnotation] = []
        for country in countries {
            if (country.countryInfo.iso2 != nil) {
                let annotation = CountryAnnotation(title: country.country, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: country.countryInfo.lat, longitude: country.countryInfo.long), flag: country.countryInfo.flag, iso2: country.countryInfo.iso2, cases: country.cases, active: country.active, death: country.deaths, recovered: country.recovered, casesPerMillion: country.casesPerOneMillion, activePerMillion: country.activePerOneMillion, deathPerMillion: country.deathsPerOneMillion, recoveredPerMillion: country.recoveredPerOneMillion)
                annotations.append(annotation)
            }
        }
        return annotations
    }
    
    func getCountries() -> [CountriesListModel] {
        let decoder = JSONDecoder()
           guard
                let url = Bundle.main.url(forResource: "countries", withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let countries = try? decoder.decode([CountriesListModel].self, from: data)
           else {
                return []
           }
           return countries
    }
}

class CountryAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    var action: (() -> Void)?
    let flag: String?
    let iso2: String?
    let cases: Int?
    let active: Int?
    let death: Int?
    let recovered: Int?
    let casesPerMillion: Double?
    let activePerMillion: Double?
    let deathPerMillion: Double?
    let recoveredPerMillion: Double?
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D, action: (() -> Void)? = nil, flag: String?,
         iso2: String?, cases: Int?, active: Int?, death: Int?, recovered: Int?, casesPerMillion: Double?, activePerMillion: Double?, deathPerMillion: Double?, recoveredPerMillion: Double?) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.action = action
        self.flag = flag
        self.iso2 = iso2
        self.cases = cases
        self.active = active
        self.death = death
        self.recovered = recovered
        self.casesPerMillion = casesPerMillion
        self.activePerMillion = activePerMillion
        self.deathPerMillion = deathPerMillion
        self.recoveredPerMillion = recoveredPerMillion
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
    @Binding var selectedPin: CountryAnnotation?
    @Binding var isMapSetUp: Bool?
        
    init(_ control: MapView, selectedPin: Binding<CountryAnnotation?>, isMapSetup: Binding<Bool?>) {
        self.mapViewController = control
        _selectedPin = selectedPin
        _isMapSetUp = isMapSetup
    }
        
    func mapView(_ mapView: MKMapView, viewFor
                    annotation: MKAnnotation) -> MKAnnotationView?{
        //Custom View for Annotation
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customCountryAnnotationView")
        annotationView.canShowCallout = false
        //Your custom image icon
        annotationView.image = UIImage(named: "pinAnnotation")
        let size = CGSize(width: 20, height: 20)
        annotationView.image = UIGraphicsImageRenderer(size:size).image {
            _ in annotationView.image!.draw(in:CGRect(origin:.zero, size:size))
        }
        annotationView.displayPriority = .defaultHigh
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let pin = view.annotation as? CountryAnnotation else {
            return
        }
        pin.action?()
        selectedPin = pin
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard (view.annotation as? CountryAnnotation) != nil else {
            return
        }
        selectedPin = nil
        isMapSetUp = true
    }
}
