//
//  PasswordInputView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct PasswordInputView: View {
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String?
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(maxWidth: .infinity,
            minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            //.foregroundColor(Color.black)
            .background(
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(.white)//.fill(Color.gray)
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

struct PasswordInputView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputView(password: .constant(""),
                          placeholder: "Password",
                          sfSymbol: "lock").preview(with: "Password + sfSymbol")
        
        PasswordInputView(password: .constant(""),
                          placeholder: "Password",
                          sfSymbol: nil).preview(with: "Password")
    }
}
