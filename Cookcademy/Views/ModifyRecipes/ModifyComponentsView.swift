//
//  ModifyComponentsView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/16/23.
//

import SwiftUI


protocol RecipeComponent: CustomStringConvertible, Codable {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifiableComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifiableComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                HStack {
                    Text(Component.pluralName().capitalized)
                        .font(.title)
                        .padding()
                    Spacer()
                    EditButton()
                        .padding()
                }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        let editComponentView = DestinationView(component: $components[index]) { _ in
                            return
                        }
                        NavigationLink(component.description, destination: editComponentView)
                            .navigationTitle("Edit " + "\(Component.singularName().capitalized)")
                    }
                    .onDelete { components.remove(atOffsets: $0) }
                    .onMove(perform: { indices, newOffset in
                        components.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())", destination: addComponentView)
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
    @State static var newRecipe = Recipe()
    static var previews: some View {
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
        NavigationStack {
            ModifyRecipeView(recipe: $newRecipe)
        }
    }
}
