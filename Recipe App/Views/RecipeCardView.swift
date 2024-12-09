//
//  RecipeCardView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 12/7/24.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: RecipeObject
    @EnvironmentObject var recipeService: RecipeService
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Card"))
                .frame(height: 150)
                .cornerRadius(10)
                .overlay(
                    VStack {
                        AsyncImage(url: URL(string: recipe.image?.isEmpty == false ? recipe.image! : "https://via.placeholder.com/150")) { image in image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .cornerRadius(10)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .foregroundColor(Color("ChocoBrown"))
                        }
                        
                        HStack {
                            Text(recipe.title)
                                .foregroundColor(Color("Text"))
                                .font(Font.custom("DeliusSwashCaps-Regular", size: 16))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                                .padding(.horizontal, 8)

                            Spacer()

                            Button(action: {
                                if recipeService.isFavorite(recipe: recipe) {
                                    recipeService.removeFromFavorites(recipe: recipe)
                                }
                                else {
                                    recipeService.addToFavorites(recipe: recipe)
                                }
                            }) {
                                Image(systemName: recipeService.isFavorite(recipe: recipe) ? "heart.fill" : "heart")
                                    .scaleEffect(recipeService.isFavorite(recipe: recipe) ? 1.20 : 1.0)
                                    .foregroundColor(Color("HeartColor"))
                                    .padding(.trailing, 10.0)
                            }
                        }
                    }
                )
        }
    }
}

#Preview {
    let sampleRecipe = RecipeObject(
        id: 1,
        title: "sample recipe",
        image: "https://via.placeholder.com/150",
        extendedIngredients: [
            Ingredient(id: 1, name: "Salt", original: "1 tsp Salt", amount: 1, unit: "tsp")
        ],
        instructions: "Mix everything together.",
        analyzedInstructions: []
    )
    RecipeCardView(recipe: sampleRecipe)
        .environmentObject(RecipeService())
}
