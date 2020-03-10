//
//  CustomerController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/1/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case badResponse
    case otherError(Error)
    case noData
    case decodeError
    case noAuth
    case invalidError
    case goodResponse
}

class CustomerController {
    
    let baseURL = URL(string: "https://foodtruck-tracker-lambda1.herokuapp.com/api")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    static let shared = CustomerController()
    var token: Token?
    
    func register(with signupData: SignUpRequest, completion: @escaping CompletionHandler) {
        let requestURL = baseURL
            .appendingPathComponent("/auth/operator/register")

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(signupData)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print(response.statusCode)
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(error)
                return
            }
            
            guard data != nil else {
                completion(error)
                return
            }
        }.resume()
    }
    
    func logIn(with loginData: LoginRequest, completion: @escaping CompletionHandler = { _ in}) {
        
        let requestURL = baseURL.appendingPathComponent("/auth/login")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(loginData)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error { completion(error); return }
            
            guard let data = data else { completion(NSError()); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let user = try jsonDecoder.decode(User.self, from: data)
                self.token = Token(id: user.id ?? 0, token: user.token ?? "")
            } catch {
                NSLog("Error decoding data/token: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func addFavoriteTruck(truck: TruckRepresentation) {
        
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
