//
//  CloseView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct CloseView: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                }).accentColor(.red)
            }
    }
}

extension View {
    func applyClose() -> some View {
        self.modifier(CloseView())
    }
}
