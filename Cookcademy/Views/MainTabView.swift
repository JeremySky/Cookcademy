//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/18/23.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            NavigationStack {
                RecipeCategoryGridView()
            }
            .tabItem {
                Label("Recipes", systemImage: "list.dash")
            }
            NavigationStack {
                RecipesListView(viewStyle: .favorites)
                
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
        .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                    appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
                    
                    // Use this appearance when scrolling behind the TabView:
                    UITabBar.appearance().standardAppearance = appearance
                    // Use this appearance when scrolled all the way up:
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
        .environmentObject(recipeData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
