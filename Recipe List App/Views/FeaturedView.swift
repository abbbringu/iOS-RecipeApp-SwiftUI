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
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .bold()
                .padding(.leading)
                .padding(.top, 40)
            
            GeometryReader { geo in
                TabView {
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
                            .sheet(isPresented: $isShowDetails, content: {
                                RecipeDetailView(recipe: model.recipes[r])
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
                Text("1 hour")
                Text("Highlights")
                    .font(.headline)
                Text("Healthy and good")
            }
            .padding(.leading)
            .padding(.bottom)
        }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
            .environmentObject(RecipeModel())
    }
}
