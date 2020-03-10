//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/27/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginAfterSignup(with loginRequest: LoginRequest)
}
enum UserType: String {
    case customer
    case grubfood
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    static var isGrubFood: Bool = false
    var customer = CustomerController()
    
    var userType: UserType?
    
    var customerController: CustomerController?
//    var grubFoodController: GrubFoodController?
    typealias CompletionHandler = (Error?) -> Void
    var token: Token?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func setupViews() {
        LoginViewController.isGrubFood = false
        userType = .customer
        
        passwordTextField.isSecureTextEntry = false
    
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let username = self.usernameTextField.text, !username.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else { return }
        
        let loginRequest = LoginRequest(username: username, password: password, email: email)
        self.login(with: loginRequest)
    }
    
    func login(with loginRequest: LoginRequest) {
        self.logIn(with: loginRequest) { (error) in
            if let error = error {
                NSLog("Error occured during login: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Signin", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Signup" {
            guard let vc = segue.destination as? signupViewController else { return }
            vc.delegate = self
        }
    }
    
    func logIn(with loginData: LoginRequest, completion: @escaping CompletionHandler = { _ in}) {
        
        let requestURL = self.customer.baseURL.appendingPathComponent("/auth/login")
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
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch loginSegmentedControl.selectedSegmentIndex {
        case 0:
            LoginViewController.isGrubFood = false
            userType = .customer
        case 1:
            LoginViewController.isGrubFood = true
            userType = .grubfood
        default:
            break
        }
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    func loginAfterSignup(with loginRequest: LoginRequest) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.login(with: loginRequest)
        }
    }
}
