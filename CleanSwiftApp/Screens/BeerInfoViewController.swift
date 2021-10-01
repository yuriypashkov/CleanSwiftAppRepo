//
//  BeerInfoViewController.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import UIKit

class BeerInfoViewController: UIViewController {
    
    // IB Outlets
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    

    var currentBeerModel: BeerModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let beer = currentBeerModel else {return}
        setUI(beer: beer)
        
    }
    
    private func setUI(beer: BeerModel) {
        // загрузим картинку
        if let imageURL = beer.beerLabelURL {
            beerImage.lazyLoadImage(urlStr: imageURL)
        }
        // заполним лейблы
        beerNameLabel.text = "\(beer.beerName ?? "Name not found")"
        beerTypeLabel.text = "\(beer.beerType ?? "Type not found")"
        beerDescriptionLabel.text = "\(beer.beerDescription ?? "Description not found")"
    }

}
