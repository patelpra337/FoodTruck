//
//  Customer+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/27/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension Customer {
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        username: String,
                                        password: String,
                                        email: String,
                                        favoriteTrucks: [Truck],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        let favoriteFoodTrucks = NSSet(object: favoriteTrucks)
        self.identifier = identifier
        self.username = username
        self.password = password
        self.email = email
        self.favoriteTrucks = favoriteFoodTrucks
    }
}
