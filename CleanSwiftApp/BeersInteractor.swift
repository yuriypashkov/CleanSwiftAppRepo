//
//  GamesInteractor.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation

protocol BeersInteractorLogic {
    func getBeers()
}


class BeersInteractor {
    var presenter: BeersPresentationLogic?
}

// в туториалах пишут, что данным запросом должен заниматься worker, не понял зачем ещё одна сущность в моём случае
extension BeersInteractor: BeersInteractorLogic {
    
    func getBeers() {
        NetworkService.shared.getBeers { result in
            switch result {
            case .success(let beers):
                self.presenter?.presentBeers(data: beers)
            case .failure:
                self.presenter?.presentError()
            }
        }
        
    }
    
}
