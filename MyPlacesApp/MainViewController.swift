//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 18.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reversedSortingButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControlOultet: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var places: Results<Place>!
    var ascendingSorting = true
        
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
        
//        segmentedControlOultet.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([segmentedControlOultet.topAnchor.constraint(equalTo: view.topAnchor), segmentedControlOultet.leftAnchor.constraint(equalTo: view.leftAnchor), segmentedControlOultet.rightAnchor.constraint(equalTo: view.rightAnchor), segmentedControlOultet.widthAnchor.constraint(equalTo: view.widthAnchor)])
        //let topConstraint = segmentedControlOultet.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
//        let verticalConstraint = NSLayoutConstraint(item: segmentedControlOultet!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaInsets.top, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 65)
        
       // view.addConstraint(topConstraint)
/*
        
           let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
           let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
           view.addConstraints([verticalConstraint, widthConstraint,])
 */
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
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
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
       sorting()
    }
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        
        ascendingSorting.toggle()
        
        if ascendingSorting == true {
            reversedSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reversedSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        if segmentedControlOultet.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
                } else {
                    places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}

