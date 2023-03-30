//
//  SessionService.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

enum SessionState {
    case loggedIn
    case loggedOut
}

struct UserSessionDetails {
    let firstName: String
    let lastName: String
    let age: String
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: UserSessionDetails? { get }
    //init()
    func logout()
}

final class SessionServiceImpl: SessionService, ObservableObject {
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserSessionDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    deinit {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
        print("deinit SessionServiceImpl")
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImpl {
    
    func setupFirebaseAuthHandler() {
        
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] res, user in
                guard let self = self else { return }
                
                //let currentUser = Auth.auth().currentUser
                self.state = user == nil ? .loggedOut : .loggedIn
                
                if let uid = user?.uid {
                    self.handleRefresh(with: uid)
                }
            }
    }
    func handleRefresh(with uid: String) {
        Database
            .database()
            .reference()
            .child("users")
            .child(uid)
            .observe(.value) { [weak self] snapshot in
                
                guard let self = self,
                      let value = snapshot.value as? NSDictionary,
                      let firstName = value[NewUserKeys.firstName.rawValue] as? String,
                      let lastName = value[NewUserKeys.lastName.rawValue] as? String,
                      let age = value[NewUserKeys.age.rawValue] as? String else {
                    return
                }

                DispatchQueue.main.async {
                    self.userDetails = UserSessionDetails(firstName: firstName,
                                                          lastName: lastName,
                                                          age: age)
                }
            }
    }
}
