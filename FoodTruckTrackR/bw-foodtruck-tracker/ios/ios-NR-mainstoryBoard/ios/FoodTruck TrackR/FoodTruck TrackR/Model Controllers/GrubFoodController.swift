//
//  VendorController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/2/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

//class GrubFoodController {
//
//    let baseURL = URL(string: "https://foodtruck-tracker-lambda1.herokuapp.com/api/")!
//    var user: GrubFoodRepresentation?
////    var token: String?
//
//    static let shared = GrubFood()
//
//    func register(user: GrubFoodSignup, completion: @escaping(NetworkError?) -> Void) {
//        let requestURL = baseURL
//                        .appendingPathComponent("Vendor")
//                        .appendingPathComponent(user.username)
//                        .appendingPathExtension("json")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.put.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let jsonEncoder = JSONEncoder()
//        do {
//            let vendorRep = GrubFoodRepresentation(username: user.username, password: user.password, email: user.email, truckOwner: [], identifier: UUID())
//            request.httpBody = try jsonEncoder.encode(vendorRep)
//        } catch {
//            print("Error encoding user: \(error)")
//            completion(.encodingError)
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse,
//            response.statusCode != 201 && response.statusCode != 200 {
//                print(response.statusCode)
//                completion(.badResponse)
//                return
//            }
//
//            if let error = error {
//                NSLog("Error signing up: \(error)")
//                completion(.otherError(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.noData)
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(GrubFoodRepresentation.self, from: data)
//                self.user = result
//                self.token = user.password
//                completion(nil)
//            } catch {
//                NSLog("Could not decode object: \(error)")
//                completion(.decodeError)
//            }
//        }.resume()
//    }
//    
//    func logOut() {
//        user = nil
//        token = nil
//    }
//
//    func logIn(user: GrubFoodLogin, completion: @escaping(NetworkError?) -> Void) {
//
//        let requestURL = baseURL.appendingPathComponent("Vendor")
//                                .appendingPathComponent(user.username)
//                                .appendingPathExtension("json")
//                                    
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 201 && response.statusCode != 200 {
//                NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
//                completion(.badResponse)
//                return
//            }
//
//            if let error = error {
//                NSLog("Error verifying user: \(error)")
//                completion(.otherError(error))
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data returned from data task")
//                completion(.noData)
//                return
//            }
//            
//            let jsonDecoder = JSONDecoder()
//            
//            do {
//                let result = try jsonDecoder.decode(GrubFoodRepresentation.self, from: data)
//                self.user = result
//                self.token = result.password
//                completion(nil)
//            } catch {
//                NSLog("Error decoding data/token: \(error)")
//                completion(.decodeError)
//                return
//            }
//        }.resume()
//    }
//
//
//    func saveToPersistentStore() {
//        do {
//            try CoreDataStack.shared.mainContext.save()
//        } catch {
//            NSLog("Error saving managed object context: \(error)")
//        }
//    }
//}
