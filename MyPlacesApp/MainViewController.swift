//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 18.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let placesNames = [
        "Mcdonalds", "Plovnaya #1", "Grabli", "KFC",
        "Dodo Pizza", "Corner Burger", "Johnjoli"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = placesNames[indexPath.row]
        cell.imageView?.image = UIImage(named: placesNames[indexPath.row])
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
