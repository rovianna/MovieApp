//
//  DateExtensions.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 28/09/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

extension String {
    var dateFormat: String {
        let dateFormatter = DateFormatter()
        let toString = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: self)
        toString.dateFormat = "dd/MM/YYYY"
        return toString.string(from: date!)
    }
}
