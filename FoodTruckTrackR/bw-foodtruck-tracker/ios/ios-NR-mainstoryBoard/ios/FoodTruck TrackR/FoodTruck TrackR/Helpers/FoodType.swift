//
//  FoodType.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/5/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

enum FoodType: String, CaseIterable, Codable {
    case breakfast = "Egg Tacos"
    case pasta = "Pasta"
    case cajun = "Cajun"
    case thai = "Thai"
    case pizza = "Pizza"
    case turkeyBurger = "Turkey Burger"
    case chinese = "Chinese"
    case wings = "Wings"
}
