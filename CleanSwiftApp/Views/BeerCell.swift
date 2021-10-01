//
//  BeerCell.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import UIKit

class BeerCell: UITableViewCell {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    
    func setCell(beer: BeerModel) {
        // делаем картинки-кругляши
        beerImage.layer.cornerRadius = beerImage.frame.size.width / 2
        // заполняем Название пива
        beerNameLabel.text = "\(beer.beerName ?? "Name not found")"
        // заполняем Тип пива
        beerTypeLabel.text = "\(beer.beerType ?? "Type not found")"
        // грузим превью-картинку
        if let beerLabelPreviewURL = beer.beerImagePreviewURL {
            beerImage.lazyLoadImage(urlStr: beerLabelPreviewURL)
        }
    }

}
