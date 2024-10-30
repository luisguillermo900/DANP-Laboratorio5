//
//  Painting.swift
//  ServiciosRestful
//
//  Created by epismac on 30/10/24.
//

import Foundation

struct Painting: Codable, Identifiable {
    let id: String
    let paintingName: String?
    let artistName: String?
    let yearOfPainting: String?
    let adjustedPrice: String?
    let originalPrice: String?
    let dateOfSale: String?
    let yearOfSale: String?
    let seller: String?
    let buyer: String?
    let auctionHouse: String?
    let imageUrl: String?
    let paintingWikipediaProfile: String?
    let artistWikipediaProfile: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case paintingName = "painting_name"
        case artistName = "artist_name"
        case yearOfPainting = "year_of_painting"
        case adjustedPrice = "adjusted_price"
        case originalPrice = "original_price"
        case dateOfSale = "date_of_sale"
        case yearOfSale = "year_of_sale"
        case seller
        case buyer
        case auctionHouse = "auction_house"
        case imageUrl = "image_url"
        case paintingWikipediaProfile = "painting_wikipedia_profile"
        case artistWikipediaProfile = "artist_wikipedia_profile"
        case description
    }
}
