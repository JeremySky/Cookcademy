//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/15/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    @Binding var recipe: Recipe
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @State private var isPresenting = false
    @EnvironmentObject private var recipeData: RecipeData
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }
                .listRowBackground(listBackgroundColor)
                
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "") " +  "\(direction.description)")
                            }
                            .foregroundColor(listTextColor)
                        }
                    }
                }.listRowBackground(listBackgroundColor)
            }
        }
        .toolbar { 
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button {
                        recipe.isFavorite.toggle()
                    } label: {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    }

                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationStack {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
                    .navigationTitle("Edit Recipe")
            }
            .onDisappear {
              recipeData.saveRecipes()
            }
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationStack {
            RecipeDetailView(recipe: $recipe)
                .environmentObject(RecipeData())
        }
    }
}
