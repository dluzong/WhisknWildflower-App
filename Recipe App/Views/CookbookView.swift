//
//  CookbookView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct CookbookView: View {
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
//                .background(Rectangle().foregroundColor(Color("ChocoBrown")))


                Text("Favorites...")
                    .padding(.top, -20.0)
                    .padding(.leading, 20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("DeliusSwashCaps-Regular", size: 20))
                    .foregroundColor(Color("Text"))
                Divider()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Array(1...8), id: \.self) { item in
                            Rectangle()
                                .fill(Color("Card")) // Replace with actual color
                                .frame(height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    ZStack {
                                        Text("Favorite Recipe \(item)")
                                            .foregroundColor(Color("Text"))
                                            .font(Font.custom("DeliusSwashCaps-Regular", size: 16))

                                        Image(systemName: "heart.fill")
                                            .foregroundColor(Color("HeartColor"))
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
}
