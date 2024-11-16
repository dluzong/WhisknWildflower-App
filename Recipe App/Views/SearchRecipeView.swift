//
//  SearchRecipeView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct SearchRecipeView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
//                    NavigationLink(destination: HomeView()){
                        Image("Whisk2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 100)
//                    }

                    Text("Find Recipes")
                        .font(Font.custom("DeliusSwashCaps-Regular", size: 30))
                        .foregroundColor(Color("Text"))
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .padding(.trailing, 20.0)
                        .foregroundColor(Color("Text"))
                        .imageScale(.large)
                }
                //.background(Rectangle().foregroundColor(Color("ChocoBrown")))


                Spacer()
                Spacer()

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Text"))
                    Text("Search Engine")
                        .foregroundColor(Color("Text"))
                    Spacer()
                }
                .padding(.top)
                .background(Rectangle().foregroundColor(Color("Search")))
                .cornerRadius(15)


                Text("Recommended...")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Text"))
                    .font(Font.custom("DeliusSwashCaps-Regular", size: 20))
                Divider()
                Spacer()

//                VStack {
//                    Text("Results Here")
//                        .foregroundColor(Color("Text"))
//                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Array(1...8), id: \.self) { item in
                            Rectangle()
                                .fill(Color("Card"))
                                .frame(height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    ZStack {
                                        Text("Recipe \(item)")
                                            .foregroundColor(Color("Text"))
                                            .font(Font.custom("DeliusSwashCaps-Regular", size: 16))
                                        
                                        Image(systemName: "heart")
                                            .foregroundColor(Color("Text"))
                                            .padding(10)
                                            .cornerRadius(10)
                                            .padding([.bottom, .trailing], 8)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                    }
                                )
                        }
                    }
                    .padding()
                }

//                NavigationLink(destination: CookbookView()) {
//                    Text("Go to Favorites")
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
    SearchRecipeView()
}
