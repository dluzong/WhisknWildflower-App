//
//  CookbookView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct CookbookView: View {
    @EnvironmentObject var recipeService: RecipeService

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
//                    Image(systemName: "person.crop.circle")
//                        .padding(.trailing, 20.0)
//                        .foregroundColor(Color("Text"))
//                        .imageScale(.large)
                }

                Text("Favorites...")
                    .padding(.top, -20.0)
                    .padding(.leading, 20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("DeliusSwashCaps-Regular", size: 20))
                    .foregroundColor(Color("Text"))
                Divider()
                if (!recipeService.favorites.isEmpty){
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(recipeService.favorites) { recipe in
                                NavigationLink(destination: RecipeDetailsView(recipe : recipe)){
                                    RecipeCardView(recipe: recipe)
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
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CookbookView()
        .environmentObject(RecipeService())
}
