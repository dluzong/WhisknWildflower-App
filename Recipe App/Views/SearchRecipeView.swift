//
//  SearchRecipeView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct SearchRecipeView: View {
    @EnvironmentObject var recipeService: RecipeService

    @State private var searchText: String = "" // Store user search input

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
                        Image("Whisk2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 100)

                    Text("Find Recipes")
                        .font(Font.custom("DeliusSwashCaps-Regular", size: 30))
                        .foregroundColor(Color("Text"))
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .padding(.trailing, 20.0)
                        .foregroundColor(Color("Text"))
                        .imageScale(.large)
                }


                Spacer()
                Spacer()

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Text"))
                    TextField("Search for recipes...", text: $searchText, onCommit: {
                        if !searchText.isEmpty {
                            print("Search triggered for \(searchText)")
                            recipeService.searchRecipes(query: searchText)
                        }
                    })
                        .foregroundColor(Color("Text"))
                        .textFieldStyle(PlainTextFieldStyle())
                    Spacer()
                }
                .padding(.top)
                .background(Color("Search"))
                .cornerRadius(15)

                Text(searchText.isEmpty ? "Recommended..." : "Search Results for \(searchText)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Text"))
                    .font(Font.custom("DeliusSwashCaps-Regular", size: 20))

                Divider()

                Spacer()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(recipeService.recipes) { recipe in
                            ZStack {
                                Rectangle()
                                    .fill(Color("Card"))
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                    .overlay(
                                        VStack {
                                            AsyncImage(url: URL(string: recipe.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 100)
                                                    .cornerRadius(10)
                                            } placeholder: {
                                                ProgressView()
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
//                                                Image(systemName: recipeService.favoriteRecipes.contains(where: {$0.id == recipe.id}) ? "heart.fill" : "heart")
//                                                    .foregroundColor(Color("Text"))
//                                                    .onTapGesture {
//                                                        if recipeService.favoriteRecipes.contains(where: {$0.id == recipe.id}) {
//                                                            recipeService.removeFromFavorites(recipe: recipe)
//                                                        } else {
//                                                            recipeService.addToFavorites(recipe: recipe)
//                                                        }
//                                                    }
//                                                    .padding(10)
//                                                    .cornerRadius(10)
//                                                    .padding([.bottom, .trailing], 8)
                                            }
                                        }
                                    )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            if recipeService.recipes.isEmpty{
                recipeService.fetchRandomRecipes()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SearchRecipeView()
        .environmentObject(RecipeService())
}
