//
//  TextInputView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct TextInputView: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity,
                   minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            .keyboardType(keyboardType)
            //.foregroundColor(Color.black)
            .background(
                ZStack(alignment: .leading) {
                    //Change Colors Here for Both Font & Box Outline
                    RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(.white)
                    if let systemImage = sfSymbol {
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading, 5)
                            .foregroundColor(Color.white.opacity(0.5))
                    }
                }
        
        )
    }
    
}

struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextInputView(text: .constant(""),
                          placeholder: "Email",
                          keyboardType: .emailAddress,
                          sfSymbol: "envelope"
            ).preview(with: "Email Text with sfSymbol")
            
            TextInputView(text: .constant(""),
                          placeholder: "First Name",
                          keyboardType: .default,
                          sfSymbol: "nil"
            ).preview(with: "First Name")
        }
    }
}
