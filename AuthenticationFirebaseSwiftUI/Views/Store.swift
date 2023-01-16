import SwiftUI

struct Store: Codable, Hashable {
    let imageURL: String
    let type: Food
    let name: String
    let location: String
    let rating: Double
    var tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case imageURL, name, location, rating, tags
        case type = "food"
    }
}

enum Food: String, Codable, CaseIterable {
    case all = "Все"
    case moscow = "Московская область"
    case petersburg = "Ленинградская область"
    case stavropol = "Ставропольский край"
    case karachaevo = "Карачаево-Черкесия"
    case krasnodar = "Краснодарский край"
    case kaliningrad = "Калининградская область"
    case kream = "Республика Крым"
}


extension Food {
    enum ErrorType: Error {
        case encoding
        case decoding
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let decodedValue = try value.decode(String.self)
        
        switch decodedValue {
        case "Московская область":
            self = .moscow
        case "Ленинградская область":
            self = .petersburg
        case "Ставропольский край":
            self = .stavropol
        case "Карачаево-Черкесия":
            self = .karachaevo
        case "Краснодарский край":
            self = .krasnodar
        case "Калининградская область":
            self = .kaliningrad
        case "Республика Крым":
            self = .kream
        default:
            print("Error occurs while decoding 'Food' key.")
            throw ErrorType.decoding
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var contrainer = encoder.singleValueContainer()
        
        switch self {
        case .moscow:
            try contrainer.encode("Московская область")
        case .petersburg:
            try contrainer.encode("Ленинградская область")
        case .stavropol:
            try contrainer.encode("Ставропольский край")
        case .karachaevo:
            try contrainer.encode("Карачаево-Черкесия")
        case .krasnodar:
            try contrainer.encode("Краснодарский край")
        case .kaliningrad:
            try contrainer.encode("Калининградская область")
        case .kream:
            try contrainer.encode("Республика Крым")
        case .all:
            try contrainer.encode("None")

        }
    }
}
