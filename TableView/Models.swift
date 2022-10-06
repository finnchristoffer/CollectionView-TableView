//
//  Models.swift
//  TableView
//
//  Created by Finn Christoffer Kurniawan on 03/10/22.
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}

struct ListCellModel {
    let title: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}
