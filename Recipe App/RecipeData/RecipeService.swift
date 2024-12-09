//
//  RecipeService.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/17/24.
//

import Foundation
import SwiftUI

class RecipeService: ObservableObject {
    @Published var recipes: [RecipeObject] = [] // Current recipes
    @AppStorage("favoriteRecipe") private var favoriteRecipes: String = "[]" // Store favorite recipes
    var favorites : [RecipeObject] {
        get {
            guard let data = favoriteRecipes.data(using: .utf8),
                 let decoded = try? JSONDecoder().decode([RecipeObject].self, from: data) else {
                     return []
                 }
            return decoded
        }
        set {
            // Encode the array into a JSON string
            if let encoded = try? JSONEncoder().encode(newValue),
               let jsonString = String(data: encoded, encoding: .utf8) {
                favoriteRecipes = jsonString
                objectWillChange.send()
            }
        }

    }
    private var randomRecipes: [RecipeObject] = [] // Cached random recipes
    private var hasFetchedRandomRecipes = false

    private let baseURLString = "https://api.spoonacular.com/recipes"
    private let apiKey = "7bc2d50e92284c389afe0ff986bf276d"

    //FETCH RANDOM RECIPES ON FIRST LOAD
    func fetchRandomRecipes(number: Int = 10) {
        guard !hasFetchedRandomRecipes else{
            self.recipes = randomRecipes //Use random recipes
            return
        }

        guard let url = URL(string: "\(baseURLString)/random?apiKey=\(apiKey)&number=\(number)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let self = self else {return}
            if let data = data, error == nil {
                do {
                    let decodedResponse = try JSONDecoder().decode(RandomRecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.randomRecipes = decodedResponse.recipes
                        self.recipes = decodedResponse.recipes
                        self.hasFetchedRandomRecipes = true
                    }
                } catch {
                    print("Failed to decode random recipes: \(error)")
                }
            }
        }.resume()
    }


    // SEARCH FOR RECIPES
    func searchRecipes(query: String, number: Int = 10) {
        guard !query.isEmpty else {
            print("query empty")
            return
        }

        guard let url = URL(string: "\(baseURLString)/complexSearch?apiKey=\(apiKey)&query=\(query)&number=\(number)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let self = self else {return}
            if let data = data, error == nil {
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchRecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.results ?? []
                        print("Search results updated: \(decodedResponse.results?.count ?? 0) recipes")
                    }
                } catch {
                    print("Failed to decode search recipes: \(error)")
                }
            }
            else {
                print("Failed to fetch search results: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

    //FETCH INGREDIENTS AND INSTRUCTIONS
    func fetchRecipeDetails(recipeID: Int, completion: @escaping (RecipeObject?) -> Void) {
        guard let url = URL(string: "\(baseURLString)/\(recipeID)/information?apiKey=\(apiKey)") else {
            print("Invalid URL for recipe details")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeObject.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch {
                    print("Failed to decode recipe details: \(error)")
                    completion(nil)
                }
            } else {
                print("Failed to fetch recipe details: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }

    // SAVE RECIPES --PERSIST DATA
    func addToFavorites(recipe: RecipeObject) {
        if !favorites.contains(where: { $0.id == recipe.id }) {
            favorites.append(recipe)
        }
    }

    func removeFromFavorites(recipe: RecipeObject) {
        if let index = favorites.firstIndex(where: { $0.id == recipe.id }) {
            favorites.remove(at: index)
        }
    }

    func isFavorite(recipe: RecipeObject) -> Bool {
        favorites.contains(where: {$0.id == recipe.id})
    }
}

// RawRepresentable Extension added to handle encoding and decoding of Array for AppStorage
extension Array: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
