//
//  TabBarView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/16/24.
//

import SwiftUI

struct TabBarView: View {

    @State private var selectedTab: Int = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Group{
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(0)
                SearchRecipeView()
                    .tabItem {
                        Label("Find Recipes", systemImage: "text.page.badge.magnifyingglass")
                    }
                    .tag(1)
                CookbookView()
                    .tabItem {
                        Label("My Cookbook", systemImage: "book")
                    }
                    .tag(2)
            }
        }
        .onAppear() {
            // Convert SwiftUI Color to UIColor
            if let backgroundColor = UIColor(named: "Search"),
               let barBackgroundColor = UIColor(named: "ChocoBrown"),
               let unselectedItemColor = UIColor(named: "DarkerYellow") {
                UITabBar.appearance().barTintColor = barBackgroundColor
                UITabBar.appearance().backgroundColor = barBackgroundColor
                UITabBar.appearance().unselectedItemTintColor = unselectedItemColor
                UITabBar.appearance().tintColor = backgroundColor // Color for selected items
            }
        }
    }
}

#Preview {
    TabBarView()
}
