//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 18.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var places: Results<Place>!
        
//        (name: "Mcdonalds", location: "Moscow", type: "Fast food", image: "Mcdonalds"),
//    Place(name: "Plovnaya #1", location: "Moscow", type: "Restaraunt", image: "Plovnaya #1"),
//    Place(name: "Grabli", location: "Moscow", type: "Cafe", image: "Grabli"),
//    Place(name: "KFC", location: "Moscow", type: "Fast food", image: "KFC"),
//    Place(name: "Dodo Pizza", location: "Moscow", type: "Fast food", image: "Dodo Pizza"),
//    Place(name: "Corner Burger", location: "Moscow", type: "Restaraunt", image: "Corner Burger"),
//    Place(name: "Johnjoli", location: "Moscow", type: "Restaraunt", image: "Johnjoli")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

         let place = places[indexPath.row]


        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace?.layer.borderWidth = 1
        cell.imageOfPlace?.layer.borderColor = UIColor.magenta.cgColor
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
//MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let place = self.places[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

           // let place = self.places[indexPath.row]
           // let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in }
            
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
/*
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     let contextItem = UIContextualAction(style: .destructive, title: deleteActionTitle) {  (contextualAction, view, boolValue) in
         //Code I want to do here
     }
     let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

     return swipeActions
 }
 */
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
    
}
