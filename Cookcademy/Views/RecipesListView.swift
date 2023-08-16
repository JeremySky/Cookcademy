//
//  RecipesListView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/15/23.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
                }
            }
        }
        .navigationTitle(navigationTitle)
    }
}

extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes
    }
    
    var navigationTitle: String {
        "All Recipes"
    }
}



struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipesListView()
        }
    }
}

