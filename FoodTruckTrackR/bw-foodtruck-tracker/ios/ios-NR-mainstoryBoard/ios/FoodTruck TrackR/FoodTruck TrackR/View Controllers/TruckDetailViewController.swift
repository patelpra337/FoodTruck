//
//  TruckDetailViewController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/7/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit
import CoreData

class TruckDetailViewController: UIViewController {
    
    @IBOutlet weak var truckNameTextField: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var truckImageView: UIImageView!
    @IBOutlet weak var locationLabel: UIButton!
    
    var truckName: String?
    var truckController = TruckController.shared
    var foodType: FoodType?
    var imageURLString: String?

    var truckRep: TruckRepresentation {
        let moc = CoreDataStack.shared.mainContext
        let request: NSFetchRequest<Truck> = Truck.fetchRequest()

        do {
            let trucks = try moc.fetch(request)
            if let truck = trucks.first,
                let truckRep = truck.truckRepresentation {
                return truckRep            }
        } catch {
            fatalError("Error fetching truck: \(error)")
        }
        return TruckRepresentation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func addTruckButton(_ sender: UIBarButtonItem) {
        guard let truckName = truckNameTextField.text, !truckName.isEmpty,
            let foodType = foodTypeTextField.text, !foodType.isEmpty else { return }
        guard let image = imageURLString else { return }
        print(image)
        truckController.createTruck(with: truckName, location: Location(longitude: 0.0, latitude: 0.0), imageOfTruck: image)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        
    }
}
