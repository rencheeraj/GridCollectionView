//
//  ProductModel.swift
//  ImageLoader
//
//  Created by Mac mini on 06/04/23.
//

import Foundation

struct ProductsModel : Codable{
    let data : [MainDataSource]?
}
struct MainDataSource : Codable{
    let title : String?
    let image : String?
}
