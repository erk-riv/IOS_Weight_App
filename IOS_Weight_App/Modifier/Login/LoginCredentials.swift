//
//  LoginCredentials.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/9/23.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static var new: LoginCredentials {
    LoginCredentials(email: "", password: "")
    }
}
