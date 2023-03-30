//
//  ForgotPasswordView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI
struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl(service: ForgotPasswordServiceImpl())
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    TextInputView(text: $vm.email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress,
                                  sfSymbol: "envelope")
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    
                    ButtonView(title: "Reset Password") {
                        vm.sendPasswordReset()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(.horizontal, 15)
            }
            .navigationTitle("Reset Password")
            .applyClose()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
