

import Foundation
import CoreLocation

protocol FindNobelLaureatesViewModelInput: class {
    func findLaureates(completion: @escaping (([LaureateViewModel]) -> (Void)))
    func setLocation(lat: Double, long: Double)
    func getLocation() -> String
    func setYear(year: String)
    func getYear() -> String
    func laureatesList() -> [NPLaureate]
}

class FindNobelLaureatesViewModel {
    
    //MARK:- Properties
    private let list: NPLaureateList
    var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var year: Int
    
    init() {
        list = NPLaureateList()
        year = NSCalendar.current.component(.year, from: Date())
    }
}

extension FindNobelLaureatesViewModel: FindNobelLaureatesViewModelInput {
    
    func findLaureates(completion: @escaping (([LaureateViewModel]) -> (Void))) {
        var vms = list.laureates.map { (laureate) -> LaureateViewModel in
            let rank = createRankFor(laureate: laureate)
            let fullname = laureate.firstname + " " + laureate.surname
            let place = laureate.city + ", " + laureate.country
            let year = laureate.year
            let location = laureate.locationString
            return LaureateViewModel(rank: rank, fullName: fullname, place: place, year: year, location: location)
        }
        //Sorting is O(n log n)
        vms.quickSort(array: &vms, low: 0, high: vms.count-1)
        completion(Array(vms.prefix(20)))
    }
    
    private func createRankFor(laureate: NPLaureate) -> Double {
        let userEnteredYear = Double(year)
        let lLocation = CLLocation(latitude: laureate.location.lat, longitude: laureate.location.lng)
        let distance = getDistanceFromSelectedLocation(loc: lLocation)

        // Making a relationship with selected year, laureate awarded year  and distance between laureate location and selected location.
        // We prepared 2 data set
        let lYear = Double(laureate.year)!
        let meanOfYears = (userEnteredYear + lYear)/2
        let mean = (meanOfYears + distance)/2.0
        let x = meanOfYears - mean
        let z = distance - mean
        let sqrSubmision = (x*x + z*z)/2
        let standardDeviationAsRank = sqrt(sqrSubmision)
        return standardDeviationAsRank
    }
    
    private func getDistanceFromSelectedLocation(loc: CLLocation) -> CLLocationDistance {
        var distance = 0.0
        if self.location.coordinate.latitude != 0 &&
            self.location.coordinate.longitude != 0 {
            distance = loc.distance(from: self.location) * 0.001
        }
        return distance
    }
    
    func setLocation(lat: Double, long: Double) {
        location = CLLocation(latitude: lat, longitude: long)
    }
    
    func getLocation() -> String {
        "\(location.coordinate.latitude), \(location.coordinate.longitude)"
    }
    
    func setYear(year: String) {
        if let y = Int(year) {
            self.year = y
        }
    }
    
    func getYear() -> String {
        "\(self.year)"
    }
    
    func laureatesList() -> [NPLaureate] {
        self.list.laureates
    }
    
}
