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
//                    Image(systemName: "person.crop.circle")
//                        .padding(.trailing, 20.0)
//                        .foregroundColor(Color("Text"))
//                        .imageScale(.large)
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
                            NavigationLink(destination: RecipeDetailsView(recipe : recipe)){
                                RecipeCardView(recipe: recipe)
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
    NavigationView {
        SearchRecipeView()
            .environmentObject(RecipeService())
    }
}
