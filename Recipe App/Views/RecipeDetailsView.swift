//
//  RecipeDetailsView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/26/24.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: RecipeObject
    //@State private var recipeDetails: RecipeObject? //model to hold recipe details
    @EnvironmentObject var recipeService: RecipeService

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
           // if let details = recipeDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
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
                        .frame(height:200)
                        .cornerRadius(10)

                        Text(recipe.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                            .font(Font.custom("DeliusSwashCaps-Regular", size: 36))

                        Text("Ingredients")
                            .font(Font.custom("DeliusSwashCaps-Regular", size: 24))
                            .font(.headline)
                        if let ingredients = recipe.extendedIngredients, !ingredients.isEmpty {
                            ForEach(ingredients, id: \.id) {
                                ingredient in Text("• \(ingredient.original)")
                                    .font(Font.custom("DeliusSwashCaps-Regular", size: 18))
                            }
                        } else {
                            Text("No ingredients available.")
                                .foregroundColor(.gray)
                        }

                        Divider()

//                        if let instructions = recipe.instructions, !instructions.isEmpty {
//                            Text("Instructions")
//                                .font(Font.custom("DeliusSwashCaps-Regular", size: 24))
//                                .font(.headline)
//                                .padding(.top)
//                            Text(instructions)
//                                .padding(.top)
//                                .font(Font.custom("DeliusSwashCaps-Regular", size: 18))
//                        } else
                        Text("Instructions")
                            .font(Font.custom("DeliusSwashCaps-Regular", size: 24))
                            .font(.headline)
                            .padding(.top)
                        if let analyzedInstructions = recipe.analyzedInstructions, !analyzedInstructions.isEmpty {
                            ForEach(analyzedInstructions, id: \.name) { instruction in
                                ForEach(instruction.steps, id: \.number) { step in
                                    Text("\(step.number). \(step.step)")
                                        .padding(.top, 2)
                                        .font(Font.custom("DeliusSwashCaps-Regular", size: 18))
                                }
                            }
                        } else {
                            Text("No instructions available.")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
//            } else {
//                ProgressView("Loading recipe details...")
//                    .onAppear {
//                        recipeService.fetchRecipeDetails(recipeID: recipeID) { details in
//                            self.recipeDetails = details
//                        }
//                    }
//            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockRecipe = RecipeObject(
            id: 1,
            title: "Mock Recipe",
            image: "https://via.placeholder.com/150",
            extendedIngredients: [
                Ingredient(id: 1, name: "Salt", original: "1 tsp Salt", amount: 1, unit: "tsp")
            ],
            instructions: "Mix everything together.",
            analyzedInstructions: []
        )

        RecipeDetailsView(recipe: mockRecipe)
}
