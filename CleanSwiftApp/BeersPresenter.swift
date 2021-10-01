//
//  GamesPresenter.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation

protocol BeersPresentationLogic {
    func presentBeers(data: [BeerData])
    func presentError()
}

class BeersPresenter{
    weak var viewController: BeersDisplayLogic?  // контроллер которым управляет презентер
}

// презентер, отвечает за то, КАК вьюконтроллер будет отоборажать информацию
extension BeersPresenter: BeersPresentationLogic {
    
    func presentError() {
        viewController?.showError()
    }
    
    
    func presentBeers(data: [BeerData]) {
        
        // презентер преобразует полученные данные в нужные для отображения и отправляет контроллеру для отображения
        let viewModel = data.map { model -> BeerModel in
            let beerModel = BeerModel(beerName: model.beerName, beerType: model.beerType, beerImagePreviewURL: model.beerLabelPreviewURL, beerLabelURL: model.beerLabelURL, beerDescription: model.beerDescription)
            return beerModel
        }
        
        viewController?.showBeers(data: viewModel)
    }
    
}
