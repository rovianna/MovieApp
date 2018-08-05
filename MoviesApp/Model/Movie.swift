//
//  Movie.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 05/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie {
    var title: String
    var date: String
    var poster: String
    
    init(title: String, date: String, poster: String) {
        self.title = title
        self.date = date
        self.poster = poster
    }
    
    init(withJSON json: JSON) {
        self.title = json["title"].stringValue
        self.date = json["release_date"].stringValue
        self.poster = json["poster_path"].stringValue
    }
}
