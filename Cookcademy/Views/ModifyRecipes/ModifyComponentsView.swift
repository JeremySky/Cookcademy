//
//  ModifyComponentsView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/16/23.
//

import SwiftUI


protocol RecipeComponent: CustomStringConvertible {
    init()
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add Component")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first component", destination: addComponentView)
                Spacer()
            } else {
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        Text(component.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another component", destination: addComponentView)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(listBackgroundColor)
                }
                .foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
    }
}