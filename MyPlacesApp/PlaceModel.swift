//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 21.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    let placesNames = [
        "Mcdonalds", "Plovnaya #1", "Grabli", "KFC",
        "Dodo Pizza", "Corner Burger", "Johnjoli"
    ]

    func savePlaces() {
        for place in placesNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            let newPlace = Place()
            
            newPlace.name = place
            newPlace.location = "Moscow"
            newPlace.type = "Fast Food"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
    }
}
