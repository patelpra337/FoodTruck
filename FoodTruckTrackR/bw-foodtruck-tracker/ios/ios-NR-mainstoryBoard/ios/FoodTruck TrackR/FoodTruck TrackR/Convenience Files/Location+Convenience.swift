//
//  Location+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/4/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension Location {
    @discardableResult convenience init(longitude: Double,
                                        latitude: Double,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.longitude = longitude
        self.latitude = latitude
    }
    convenience init(location: LocationRepresentation) {
        self.init(longitude: location.longitude, latitude: location.latitude)
    }
}
