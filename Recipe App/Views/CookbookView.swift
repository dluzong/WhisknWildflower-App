//
//  CookbookView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct CookbookView: View {
    @EnvironmentObject var recipeService: RecipeService
    //@State private var favoriteRecipes: [RecipeObject] = []

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
                    NavigationLink(destination: HomeView()){
                        Image("Whisk2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 100)
                    }
                    Text("My Cookbook")
                        .font(Font.custom("DeliusSwashCaps-Regular", size: 30))
                        .foregroundColor(Color("Text"))
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .padding(.trailing, 20.0)
                        .foregroundColor(Color("Text"))
                        .imageScale(.large)
                }

                Text("Favorites...")
                    .padding(.top, -20.0)
                    .padding(.leading, 20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("DeliusSwashCaps-Regular", size: 20))
                    .foregroundColor(Color("Text"))
                Divider()
                if (!recipeService.favoriteRecipes.isEmpty){
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(recipeService.favoriteRecipes) { recipe in
                                ZStack {
                                    Rectangle()
                                        .fill(Color("Card")) // Replace with actual color
                                        .frame(height: 150)
                                        .cornerRadius(10)
                                        .overlay(
                                            VStack {
                                                AsyncImage(url: URL(string: recipe.image)) { image in image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 100)
                                                        .cornerRadius(10)
                                                } placeholder: {
                                                    ProgressView()
                                                }
    //                                            Image(systemName: "heart.fill")
    //                                                .foregroundColor(Color("HeartColor"))
    //                                                .padding(10)
    //                                                .cornerRadius(10)
    //                                                .padding([.bottom, .trailing], 8)
    //                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                                Text(recipe.title)
                                                    .foregroundColor(Color("Text"))
                                                    .font(Font.custom("DeliusSwashCaps-Regular", size: 14))
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(2)
                                                    .padding(.horizontal, 8)
                                            }
                                        )
                                }

                            }
                        }
                        .padding()
                    }
                } else {
                    Spacer()
                    Text("No favorite recipes")
                        .foregroundColor(Color("Text"))
                        .font(Font.custom("DeliusSwashCaps-Regular", size: 20))
                    Spacer()
                    Spacer()
                }


//                NavigationLink(destination: SearchRecipeView()) {
//                    Text("Find more Recipes")
//                        .padding()
//                        .background(Color("ChocoBrown"))
//                        .foregroundColor( Color("BackgroundColor"))
//                        .cornerRadius(45)
//                        .font(Font.custom("DeliusSwashCaps-Regular", size: 18))
//                }

            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CookbookView()
        .environmentObject(RecipeService())
}
