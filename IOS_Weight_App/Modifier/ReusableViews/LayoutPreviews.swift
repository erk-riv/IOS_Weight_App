//
//  LayoutPreviews.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct LayoutPreview: ViewModifier {
    let name: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
                .previewDisplayName(name)
            .padding()
    }
}

extension View {
    func preview(with name: String) -> some View {
        self.modifier(LayoutPreview(name: name))
    }
}
