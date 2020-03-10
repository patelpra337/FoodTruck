//
//  User.swift
//  FoodTruck TrackR
//
//  Created by Alex Thompson on 3/8/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int?
    let username: String?
    let password: String?
    let email: String?
    let token: String?
}
