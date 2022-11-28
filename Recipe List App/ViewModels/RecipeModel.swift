//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
        
    }
    
    static func getPorportion(ingredient:Ingredeients, recipeServing:Int, targetServing:Int) -> String {
        var proportion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            // Calculate the denominator and nuerator for the target serving
            denominator *= recipeServing
            numerator *= targetServing
            
            // Find the greatest common divisor
            let divisor = Rational.greatestCommonDivisor(denominator, numerator)
            // Apply and simplify
            denominator /= divisor
            numerator /= divisor
            // Turn into whole units
            if numerator >= denominator {
                wholePortions = numerator / denominator
                numerator = numerator % denominator
                // Appending whole units to propotion
                proportion += String(wholePortions)
            }
            if numerator > 0 {
                proportion += wholePortions > 0 ? " " : ""
                proportion += "\(numerator)/\(denominator)"
            }
        }
        if let unit = ingredient.unit {
            proportion += " " + unit
            if wholePortions > 1 {
                return proportion + "s"
            }
        }
        return proportion
    }
}
