// BookModel.swift
// DemoLogin
// Created by Keshav Lohiya on 11/07/24.

import Foundation

struct Book: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let volumeInfo: VolumeInfo
        let saleInfo: SaleInfo
        
        struct VolumeInfo: Codable {
            let title: String
            let authors: [String]?
            let description: String?
            let publisher: String?
            let averageRating: Double?
            let previewLink: String?
            let imageLinks: ImageLinks?
            
            struct ImageLinks: Codable {
                let smallThumbnail: String
                let thumbnail: String
            }
        }
        
        struct SaleInfo: Codable {
            let retailPrice: Price?
            
            struct Price: Codable {
                let amount: Double
                let currencyCode: String
            }
        }
    }
}
