//
//  HomeView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/8/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("First Name: \(sessionService.userDetails?.firstName ?? "N/A")")
                       .foregroundColor(.white)
                    Text("Last Name: \(sessionService.userDetails?.lastName ?? "N/A")")
                        .foregroundColor(.white)
                    Text("Age: \(sessionService.userDetails?.age ?? "N/A")")
                        .foregroundColor(.white)
                }
                
                ButtonView(title: "Logout") {
                    sessionService.logout()
                }
            }.padding(.horizontal, 16)
        }.navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView().environmentObject(SessionServiceImpl())
        }
    }
}
