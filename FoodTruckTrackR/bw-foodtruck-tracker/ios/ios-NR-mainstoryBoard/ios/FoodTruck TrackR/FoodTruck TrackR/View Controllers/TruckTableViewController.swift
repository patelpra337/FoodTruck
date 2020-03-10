//
//  TruckTableViewController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/7/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class TruckTableViewController: UITableViewController {
    
    private var truckNames: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let truckController = TruckController()
    let customerController = CustomerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckCell", for: indexPath)

        cell.textLabel?.text = truckNames[indexPath.row]

        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TruckLoginViewModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.customerController = customerController
            }
        } else if segue.identifier == "TruckDetailSegue" {
            guard let detailVC = segue.destination as? TruckDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard indexPath.row < truckNames.count else { return }
            
            detailVC.truckName = truckNames[indexPath.row]
            detailVC.truckController = truckController
        }
    }    
}
