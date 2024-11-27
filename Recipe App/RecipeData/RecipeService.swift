//
//  RecipeService.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/17/24.
//

import Foundation

class RecipeService: ObservableObject {
    @Published var recipes: [RecipeObject] = [] // Current recipes
    @Published var favoriteRecipes: [RecipeObject] = [] //Store favorite recipes
    private var randomRecipes: [RecipeObject] = [] // Cached random recipes
    private var hasFetchedRandomRecipes = false

    private let baseURLString = "https://api.spoonacular.com/recipes"
    private let apiKey = "7bc2d50e92284c389afe0ff986bf276d"

    //Fetch random recipes on first load
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
                    }
                } catch {
                    print("Failed to decode search recipes: \(error)")
                }
            }
        }.resume()
    }

    func addToFavorites(recipe: RecipeObject) {
            if !favoriteRecipes.contains(where: { $0.id == recipe.id }) {
                favoriteRecipes.append(recipe)
            }
        }

    func removeFromFavorites(recipe: RecipeObject) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        }
    }
}
