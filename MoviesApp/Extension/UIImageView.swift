//
//  UIImageView.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 05/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, task, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
}
