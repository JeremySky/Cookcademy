//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/16/23.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
            ingredients.append(ingredient)
            newIngredient = Ingredient()
        }
        VStack {
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }
                .foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    @State static var ingredients = [Ingredient(name: "asdf", quantity: 0.5, unit: .cups)]
    static var previews: some View {
        NavigationStack {
            ModifyIngredientsView(ingredients: $emptyIngredients)
        }
        NavigationStack {
            ModifyIngredientsView(ingredients: $ingredients)
        }
    }
}
