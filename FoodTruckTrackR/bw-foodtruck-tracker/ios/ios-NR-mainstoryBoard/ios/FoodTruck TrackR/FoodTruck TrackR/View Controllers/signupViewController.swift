//
//  signupViewController.swift
//  FoodTruckTrackr
//
//  Created by Nicolas Rios on 2/27/20.
//  Copyright © 2020 Nicolas Rios. All rights reserved.
//

import UIKit


class signupViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    typealias CompletionHandler = (Error?) -> Void
    var userType: UserType?
    var customerController = CustomerController()
//    var grubFoodController: GrubFoodController?
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        userType = .customer
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else {
                let alert = UIAlertController(title: "Missing fields", message: "Check your info and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        // create a signup form
        let signUpRequest = SignUpRequest(username: username, password: password, email: email)
        
        self.signupButton.isEnabled = false
        
        self.register(with: signUpRequest) { error in
            DispatchQueue.main.async {
                if let _ = error {
                    let alert = UIAlertController(title: "Something went wrong", message: "Please try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    // enable sign up button if something goes wrong
                    self.signupButton.isEnabled = true
                    return
                } else {
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.loginAfterSignup(with: LoginRequest(username: username, password: password, email: email))
                }
            }
        }
    }
    
    func register(with signupData: SignUpRequest, completion: @escaping CompletionHandler) {
        let requestURL = customerController.baseURL
            .appendingPathComponent("/auth/operator/register")
        print(requestURL)

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
                response.statusCode != 201 {
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
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 201 {
                print("We have succeeded in signing up")
                completion(nil)
                return
            } else {
                print("Error signing up: Did not return a response status code of 201")
                completion(NSError(domain: "", code: -1, userInfo: nil))
                return
            }
            
        }.resume()
    }
}
