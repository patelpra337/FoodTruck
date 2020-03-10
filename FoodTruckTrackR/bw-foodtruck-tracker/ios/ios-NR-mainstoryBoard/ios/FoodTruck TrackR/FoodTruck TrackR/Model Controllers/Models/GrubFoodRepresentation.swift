//
//  GrubFoodRepresentation.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/2/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    var username: String
    var password: String
    var email: String
}

struct SignUpRequest: Codable {
    var username: String
    var password: String
    var email: String
}

class GrubFoodRepresentation: Codable, Equatable {
    
    var username: String
    var password: String
    var email: String
    var truckOwner: [TruckRepresentation]
    var identifier: UUID
    
    init(username: String, password: String, email: String, truckOwner: [TruckRepresentation], identifier: UUID) {
        self.username = username
        self.password = password
        self.email = email
        self.truckOwner = truckOwner
        self.identifier = identifier
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let username = try container.decode(String.self, forKey: .username)
        let password = try container.decode(String.self, forKey: .password)
        let email = try container.decode(String.self, forKey: .email)
        let trucksDict = try container.decodeIfPresent([String: TruckRepresentation].self, forKey: .truckOwner)
        var trucks: [TruckRepresentation] = []
        if let temp = trucksDict {
            trucks = Array(temp.values)
        }
        let identifier = try container.decode(String.self, forKey: .identifier)
        guard let id = UUID(uuidString: identifier) else { throw NSError() }
        
        self.username = username
        self.password = password
        self.email = email
        self.truckOwner = trucks
        self.identifier = id
    }
    
    static func == (lhs: GrubFoodRepresentation, rhs: GrubFoodRepresentation) -> Bool {
        return lhs.username == rhs.username &&
            lhs.password == rhs.password &&
            lhs.email == rhs.email &&
            lhs.identifier == rhs.identifier
    }
}




