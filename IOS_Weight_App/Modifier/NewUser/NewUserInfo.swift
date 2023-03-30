//
//  NewUserInfo.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/9/23.
//

import Foundation

struct NewUserInfo {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var age: String
}

extension NewUserInfo {
    static var new: NewUserInfo {
        NewUserInfo(email: "",
                    password: "",
                    firstName: "",
                    lastName: "",
                    age: "")
    }
}
