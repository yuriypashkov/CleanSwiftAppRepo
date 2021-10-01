//
//  NewsData.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import Foundation

struct BeerData: Decodable {
    
    var id: String?
    var beerName: String?
    var beerType: String?
    var beerDescription: String?
    var beerLabelURL: String?
    var beerLabelPreviewURL: String?
    var untappdURL: String?
    var breweryID: Int?
    var comment: String?
}
