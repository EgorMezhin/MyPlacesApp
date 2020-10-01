//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by Egor Lass on 21.09.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit

struct Place {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var placeImage: String?
    
    static let placesNames = [
        "Mcdonalds", "Plovnaya #1", "Grabli", "KFC",
        "Dodo Pizza", "Corner Burger", "Johnjoli"
    ]

    static func getPlaces() -> [Place] {
        var places = [Place]()
        for place in placesNames {
            places.append(Place(name: place, location: "1", type: "2", image: nil, placeImage: place))
        }
        
        return places
    }
}
