//
//  Recipe_AppApp.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

@main
struct Recipe_AppApp: App {
    @StateObject private var recipeService = RecipeService()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(recipeService)
        }
    }
}
