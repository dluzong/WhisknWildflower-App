//
//  RecipeObject.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/17/24.
//

import Foundation

struct RandomRecipeResponse: Codable {
    let recipes : [RecipeObject]
}

struct SearchRecipeResponse: Codable {
    let results : [RecipeObject]?
}

struct RecipeObject: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
}
