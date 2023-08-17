//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Jeremy Manlangit on 8/17/23.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    
    @Binding var direction: Direction
    let createAction: ((Direction) -> Void)
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    var body: some View {
        Color(.red)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var newDirection = Direction()
    static var previews: some View {
        ModifyDirectionView(component: $newDirection) { direction in
            print(direction)
        }
    }
}
