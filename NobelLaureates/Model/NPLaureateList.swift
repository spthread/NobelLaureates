

import Foundation

struct NPLaureateList: Codable {
    // MARK:- Properties
    private(set) var laureates: [NPLaureate]
    
    init() {
        laureates = []
        laureates = load()
    }
    
    private func getLaureateListData() -> Data {
        guard
            let path = Bundle.main.path(forResource: FindNobelLaureatesConstants.Nobel_Price_Laureates_FileName, ofType: FindNobelLaureatesConstants.FileType),
            let data = FileManager.default.contents(atPath: path)
        else {
            return Data()
        }
        
        return data
    }
    
    private func load() -> [NPLaureate] {
        do {
            let data = getLaureateListData()
            let decoder = JSONDecoder()
            let list = try decoder.decode([NPLaureate].self, from: data)
            return list
        }
        catch let ex {
            print("Exception - \(ex.localizedDescription)")
            return []
        }
    
    }
}
