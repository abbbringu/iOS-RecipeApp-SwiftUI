//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    @State var portionSize = 4
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                VStack (alignment: .leading) {
                    
                    // MARK: Recipe Image
                    Image(recipe.image)
                        .resizable()
                        .scaledToFill()
                    
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    
                    VStack (alignment: .leading){
                        Text("Choose your proportion size:")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
                        Picker("Portion size", selection: $portionSize) {
                            Text("2").tag(2)
                            Text("4").tag(4)
                            Text("6").tag(6)
                            Text("8").tag(8)
                        }
                        .frame(width: geo.size.width / 1.5)
                        .pickerStyle(.segmented)
                    }
                    .padding([.leading,.bottom,.trailing])
                    
                    Divider()
                    // MARK: Ingredients
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.headline)
                            .padding([.bottom, .top], 5)
                        
                        ForEach (recipe.ingredients) { item in
                            Text("• " + RecipeModel.getPorportion(ingredient: item,
                                                                  recipeServing: recipe.servings,
                                                                  targetServing: portionSize) + " " + item.name.lowercased())
                            // RecipeModel.getPorportion(ingredients: item, recipeServing: recipe.servings, targetServing: portionSize) +
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: Divider
                    Divider()
                    
                    // MARK: Directions
                    VStack(alignment: .leading) {
                        Text("Directions")
                            .font(.headline)
                            .padding([.bottom, .top], 5)
                        
                        ForEach(0..<recipe.directions.count, id: \.self) { index in
                            
                            Text(String(index+1) + ". " + recipe.directions[index])
                                .padding(.bottom, 5)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Create a dummy recipe and pass it into the detail view so that we can see a preview
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
