//
//  CategoriesModel.swift
//  StarMaker
//
//  Created by Raghu on 30/06/23.
//

import Foundation



// MARK: - Categories
struct Categories: Codable {
    var categoryList: [CategoryList]?
}

// MARK: - CategoryList
struct CategoryList: Codable {
    var category: String?
    var subcategory: [Subcategory]?
}

// MARK: - Subcategory
struct Subcategory: Codable {
    var title: String?
    var isSelected: Bool?
    var url: [String]?
}
