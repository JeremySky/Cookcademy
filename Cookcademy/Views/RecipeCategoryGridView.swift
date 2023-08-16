//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/16/23.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        let columns = [GridItem(), GridItem()]
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases,
                            id: \.self) { category in
                        NavigationLink {
                            RecipesListView(category: category)
                                .environmentObject(recipeData)
                        } label: {
                            CategoryView(category: category)
                        }
                        
                    }
                })
            }
        }
        .navigationTitle("Categories")
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipeCategoryGridView()
        }
    }
}

