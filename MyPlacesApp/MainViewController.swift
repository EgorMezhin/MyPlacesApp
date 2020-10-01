//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 18.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var places = Place.getPlaces()
        
//        (name: "Mcdonalds", location: "Moscow", type: "Fast food", image: "Mcdonalds"),
//    Place(name: "Plovnaya #1", location: "Moscow", type: "Restaraunt", image: "Plovnaya #1"),
//    Place(name: "Grabli", location: "Moscow", type: "Cafe", image: "Grabli"),
//    Place(name: "KFC", location: "Moscow", type: "Fast food", image: "KFC"),
//    Place(name: "Dodo Pizza", location: "Moscow", type: "Fast food", image: "Dodo Pizza"),
//    Place(name: "Corner Burger", location: "Moscow", type: "Restaraunt", image: "Corner Burger"),
//    Place(name: "Johnjoli", location: "Moscow", type: "Restaraunt", image: "Johnjoli")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
            
            
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        
        if place.image == nil {
                   cell.imageOfPlace?.image = UIImage(named: place.placeImage!)
        } else {
            cell.imageOfPlace.image = place.image
        }
       
        cell.imageOfPlace?.layer.borderWidth = 1
        cell.imageOfPlace?.layer.borderColor = UIColor.magenta.cgColor
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
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
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
    
}
