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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = placesNames[indexPath.row]
        cell.imageOfPlace?.image = UIImage(named: placesNames[indexPath.row])
        cell.imageOfPlace?.layer.borderWidth = 1
        cell.imageOfPlace?.layer.borderColor = UIColor.magenta.cgColor
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
