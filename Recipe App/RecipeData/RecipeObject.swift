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
    let image: String?
//    let readyInMinutes: Int?
//    let servings: Int?
    let extendedIngredients: [Ingredient]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let original: String
    let amount: Double
    let unit: String
}

struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
}
