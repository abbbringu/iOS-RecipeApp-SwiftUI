//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Brian Nguyen on 2022-11-25.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView {
            FeaturedView()
                .tabItem {
                    VStack{
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            RecipeListView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
            .environmentObject(RecipeModel())
    }
}
