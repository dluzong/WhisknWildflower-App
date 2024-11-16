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
                    Spacer()

                    Text("Whisk&Wildflower")
                        .font(Font.custom("Shizuru-Regular", size: 50))
                    Image("Whisk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0.0)
                        .frame(width: 300 , height: 280)

                    HStack {
                        Spacer()
                        NavigationLink(destination: TabBarView()) {
                            Text("Find Recipes")
        
                                .padding()
                                .background(Color("ChocoBrown"))
                                .foregroundColor( Color("BackgroundColor"))
                                .cornerRadius(45)
                                .font(Font.custom("DeliusSwashCaps-Regular", size: 30))
                        }
                        .padding(.top, 40.0)
//                        Spacer()
//                        NavigationLink(destination: CookbookView()) {
//                            Text("My Cookbook")
//                                .padding()
//                                .background(Color("Brown"))
//                                .foregroundColor( Color("BackgroundColor"))
//                                .cornerRadius(45)
//                                .font(Font.custom("DeliusSwashCaps-Regular", size: 18))
//                        }

                        Spacer()
                    }
                    .padding(.top, 20.0)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
