//
//  BeersRouter.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation
import UIKit

protocol BeersRoutingLogic {
    func navigateToBeer(beer: BeerModel)
}

class BeersRouter {
    weak var viewController: UIViewController?
}

extension BeersRouter: BeersRoutingLogic {
    
    func navigateToBeer(beer: BeerModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let beerInfoViewController = storyboard.instantiateViewController(identifier: "BeerInfoViewController") as? BeerInfoViewController else {
            return
        }
        // передаём контроллеру данные, не самый оптимальный метод
        beerInfoViewController.currentBeerModel = beer
        // открываем контроллер
        viewController?.navigationController?.pushViewController(beerInfoViewController, animated: true)
    }
    
}
