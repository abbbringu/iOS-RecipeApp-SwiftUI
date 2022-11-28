//
//  FeaturedView.swift
//  Recipe List App
//
//  Created by Brian Nguyen on 2022-11-26.
//

import SwiftUI

struct FeaturedView: View {
    @EnvironmentObject var model:RecipeModel
    @State var isShowDetails = false
    @State var tabIndex = 0
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .bold()
                .padding(.leading)
                .padding(.top, 40)
            
            GeometryReader { geo in
                TabView (selection: $tabIndex) {
                    ForEach (0 ..< model.recipes.count) { r in
                        
                        if model.recipes[r].featured {
                            Button {
                                self.isShowDetails = true
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    VStack(spacing: 0){
                                        Image(model.recipes[r].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill
                                            )
                                            .clipped()
                                        Text(model.recipes[r].name)
                                            .padding(5)
                                    }
                                }
                            }
                            .tag(r)
                            .sheet(isPresented: $isShowDetails, content: {
                                RecipeDetailView(recipe: model.recipes[tabIndex])
                            })
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40,
                                   height: geo.size.height - 100)
                            .cornerRadius(20)
                            .shadow(radius: 10,
                                    x: -5,
                                    y: 5)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("Preperation Time")
                    .font(.headline)
                Text(model.recipes[tabIndex].prepTime)
                Text("Highlights")
                    .font(.headline)
                highlightView(highlights: model.recipes[tabIndex].highlights)
            }
            .padding(.leading)
            .padding(.bottom)
        }
        .onAppear {
            getFirstFeaturedIndex()
        }
    }
    
    func getFirstFeaturedIndex() {
        let index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        
        tabIndex = index ?? 0
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
            .environmentObject(RecipeModel())
    }
}
