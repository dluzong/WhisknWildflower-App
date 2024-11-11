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
                    Spacer()

                }
                .background(Rectangle().foregroundColor(Color("Brown")))


                Text("Favorites...")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                Spacer()

                VStack {
                    Text("Add Favorites")
                }

                Spacer()

                NavigationLink(destination: SearchRecipeView()) {
                    Text("Find more Recipes")
                        .padding()
                        .background(Color("Brown"))
                        .foregroundColor( Color("BackgroundColor"))
                        .cornerRadius(45)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    CookbookView()
}
