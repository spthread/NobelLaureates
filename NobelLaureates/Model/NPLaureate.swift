
import Foundation

struct NPLaureate: Codable {
    // MARK:- Properties
    let id: Int
    let category: String
    let died: String
    let diedcity: String
    let borncity: String
    let born: String
    let surname: String
    let firstname: String
    let motivation: String
    let location: NPLLocation
    let city: String
    let borncountry: String
    let year: String
    let diedcountry: String
    let country: String
    let gender: String
    let name: String
    
    var locationString: String {
        "\(self.location.lat), \(self.location.lng)"
    }
}
