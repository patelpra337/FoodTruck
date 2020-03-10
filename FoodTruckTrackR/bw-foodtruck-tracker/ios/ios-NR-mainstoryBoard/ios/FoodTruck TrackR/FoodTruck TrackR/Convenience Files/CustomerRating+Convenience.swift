//
//  CustomerRating+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/29/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension CustomerRating {
    @discardableResult convenience init(customerRating: Int, comments: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.customerRating = Int16(customerRating)
        self.comments = comments
    }
}
