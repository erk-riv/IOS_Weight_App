//
//  IOS_Weight_AppApp.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/7/23.
//

import SwiftUI
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    return true
  }
}

@main
struct IOS_Weight_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                    case .loggedIn:
                        HomeView().environmentObject(sessionService)
                    case .loggedOut:
                        SignInView()
                }
            }
        }
    }
}
