//
//  MenuPhoto+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/29/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension MenuPhoto {
    @discardableResult convenience init(photoURL: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.photoURL = photoURL
    }
}
