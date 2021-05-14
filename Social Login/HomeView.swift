//
//  HomeView.swift
//  Social Login
//
//  Created by Mac Os on 30/04/21.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

struct HomeView : View {
    
    @State var user = Auth.auth().currentUser

    var body: some View
    {
        VStack {
            
            Text("Welcome \(Auth.auth().currentUser!.email!)")
            
            
        }
    }
}

struct HomeView_Preview : PreviewProvider {
    
    static var previews: some View
    {
        HomeView()
    }
}
