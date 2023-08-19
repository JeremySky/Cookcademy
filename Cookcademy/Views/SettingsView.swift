//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/19/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var hideOptionalSteps: Bool = false
    @State private var listBackgroundColor = AppColor.background
    @State private var listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
                .padding()
                .listRowBackground(listBackgroundColor)
            ColorPicker("Text Color", selection: $listTextColor)
                .padding()
                .listRowBackground(listBackgroundColor)
            Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                .padding()
                .listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
