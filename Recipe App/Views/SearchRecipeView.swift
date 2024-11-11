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
                    NavigationLink(destination: HomeView()){
                        Image("Whisk2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 100)
                    }

                    Text("Find Recipes")
                        .foregroundColor(Color("Text"))
                    Spacer()

                }
                .background(Rectangle().foregroundColor(Color("Brown")))


                Text("Recommended...")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Text"))
                Divider()

                Spacer()

                VStack {
                    Text("Results Here")
                        .foregroundColor(Color("Text"))
                }

                Spacer()

                NavigationLink(destination: CookbookView()) {
                    Text("Go to Favorites")
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
    SearchRecipeView()
}
