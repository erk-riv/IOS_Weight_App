//
//  SignInView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct SignInView: View {
    @State private var showRegister = false
    @State private var showForgotPassword = false
    @StateObject private var vm = LoginViewModelImpl(service: LoginServiceImpl())
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .cornerRadius(4)
                    .padding(.bottom, 150)
                
                VStack(spacing: 16) {
                    TextInputView(text: $vm.credentials.email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress,
                                  sfSymbol: "envelope") .disableAutocorrection(true)
                                      .autocapitalization(.none)
                    
                    PasswordInputView(password: $vm.credentials.password,
                                      placeholder: "Password",
                                      sfSymbol: "lock")
                                      .disableAutocorrection(true)
                                      .autocapitalization(.none)
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        showForgotPassword.toggle()
                    }, label: {
                        Text("Forgot Password?")
                    }).font(.system(size: 16, weight: .bold))
                        .sheet(isPresented: $showForgotPassword, content: {
                            ForgotPasswordView()
                        })
                }
                
                VStack(spacing: 16) {
                    ButtonView(title: "Sign In") {
                        vm.login()
                    }
                    
                    ButtonView(title: "Register",
                               background: .clear,
                               foreground: .red,
                               border: .red) {
                        showRegister.toggle()
                    }
                               .sheet(isPresented: $showRegister, content: {
                                   RegisterView()
                               })
                }
            }.padding(.horizontal, 15)
        }.navigationTitle("Login")
            .alert(isPresented: $vm.hasError,
                   content: {
                if case .failed(let error) = vm.state {
                    return Alert(title: Text("Error"),
                                 message: Text(error.localizedDescription))
                } else {
                    return Alert(title: Text("Error"),
                                 message: Text("Something went wrong"))
                }
            })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
