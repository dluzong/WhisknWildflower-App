//
//  ContentView.swift
//  Recipe App
//
//  Created by Daphne Luzong on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Whisk & Wildflower")
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
