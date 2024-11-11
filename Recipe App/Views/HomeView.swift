//
//  HomeView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack {
                    
                    Text("Whisk&Wildflower")
                        .font(Font.custom("Shizuru-Regular", size: 50))
                    Image("Whisk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 30.0)
                        .frame(width: 300 , height: 280)

                    HStack {
                        Spacer()
                        NavigationLink(destination: SearchRecipeView()) {
                            Text("Find Recipes")
                                .padding()
                                .background(Color("Brown"))
                                .foregroundColor( Color("BackgroundColor"))
                                .cornerRadius(45)
                        }
                        Spacer()
                        NavigationLink(destination: CookbookView()) {
                            Text("My Cookbook")
                                .padding()
                                .background(Color("Brown"))
                                .foregroundColor( Color("BackgroundColor"))
                                .cornerRadius(45)
                        }
                        Spacer()
                    }
                    .padding(.top, 20.0)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
