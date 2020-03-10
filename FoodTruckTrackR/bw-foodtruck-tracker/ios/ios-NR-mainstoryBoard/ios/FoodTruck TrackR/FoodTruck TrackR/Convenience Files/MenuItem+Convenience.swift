//
//  MenuItem+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/29/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension MenuItem {
    @discardableResult convenience init(itemName: String,
                                        itemDescription: String,
                                        itemPhotos: [MenuPhoto],
                                        itemPrice: Double,
                                        customerRating: [CustomerRating],
                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.itemName = itemName
        self.itemDescription = itemDescription
    }
}
