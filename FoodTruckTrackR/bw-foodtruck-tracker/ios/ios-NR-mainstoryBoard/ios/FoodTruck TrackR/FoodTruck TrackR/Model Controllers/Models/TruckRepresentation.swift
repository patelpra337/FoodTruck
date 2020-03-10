//
//  TruckRepresentation.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/1/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//


import Foundation

struct TruckRepresentation: Codable {
    var location: LocationRepresentation
    var identifier: UUID
    var truckName: String
    var imageOfTruck: String
    var cuisineType: String?
    var customerRating: Double
    
    init(location: LocationRepresentation = LocationRepresentation(longitude: 0.0, latitude: 0.0),
        imageOfTruck: String = "",
        customerRating: Double = 0.0,
        truckName: String = "",
        cuisineType: String? = nil,
        identifier: UUID = UUID()) {
        
        self.location = location
        self.imageOfTruck = imageOfTruck
        self.customerRating = customerRating
        self.truckName = truckName
        self.cuisineType = cuisineType
        self.identifier = identifier
    }
}
