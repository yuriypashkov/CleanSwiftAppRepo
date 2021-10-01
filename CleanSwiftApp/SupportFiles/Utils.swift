//
//  Utils.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func lazyLoadImage(urlStr: String) {
    
        let spinner = UIActivityIndicatorView()
        spinner.center = self.center
        spinner.color = .red
        spinner.hidesWhenStopped = true
        self.addSubview(spinner)
        spinner.startAnimating()
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        self.image = UIImage(data: data)
                        spinner.stopAnimating()
                    } else {
                        self.image = UIImage(named: "beerImageError")
                        spinner.stopAnimating()
                    }
                }
            }.resume()
        }
    }
}
