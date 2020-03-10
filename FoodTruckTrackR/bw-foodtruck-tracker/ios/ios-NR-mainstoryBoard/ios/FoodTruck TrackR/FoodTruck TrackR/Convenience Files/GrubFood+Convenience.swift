//
//  GrubFood+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/1/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension GrubFood {
    @discardableResult convenience init(username: String, password: String, email: String, truckOwner: [Truck], identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.username = username
        self.password = password
        self.email = email
        // self.truckOwner = NSOrderedSet(object: truckOwner)
        self.identifier = identifier
    }
    
    convenience init(user: GrubFoodRepresentation) {
        var trucks: [Truck] = []
        for truck in user.truckOwner {
            trucks.append(Truck(truck: truck))
        }
        
        self.init(username: user.username, password: user.password, email: user.email, truckOwner: trucks)
    }
}
