//
//  University.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import Foundation
import RealmSwift

class University: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var stateProvince: String?
    @objc dynamic var webPage: String = ""
    @objc dynamic var domain: String = ""

    enum CodingKeys: String, CodingKey {
        case name
        case country
        case stateProvince = "state-province"
        case webPage = "web_pages"
        case domain = "domains"
    }
    
    required override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
        self.stateProvince = try? container.decode(String?.self, forKey: .stateProvince)
        self.webPage = (try container.decode([String].self, forKey: .webPage)).first ?? ""
        self.domain = (try container.decode([String].self, forKey: .domain)).first ?? ""
        super.init()
    }

    override class func primaryKey() -> String? {
        return "name"
    }
}
