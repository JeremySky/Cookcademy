//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/15/23.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
