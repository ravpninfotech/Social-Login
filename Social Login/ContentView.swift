//
//  ContentView.swift
//  Social Login
//
//  Created by Mac Os on 30/04/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FBSDKLoginKit

struct ContentView: View {
    
    @State var user = Auth.auth().currentUser
    private let premission = ["public_profile", "email"]
    @State var isLogin = false
    
    var body: some View {
        VStack {
//            HStack {
                Button(action: {
                    
                    if !isLogin
                    {
                        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                        GIDSignIn.sharedInstance()?.signIn()
//                        isLogin = true
                    }else{
                        GIDSignIn.sharedInstance()?.signOut()
                        try! Auth.auth().signOut()
                        isLogin = false
                    }
                    
                }, label: {
                    Image(!isLogin ? "google" : "logout")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                })
                .frame(width: 50, height: 50, alignment: .center)
                .onAppear {
                    
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
                        
                        self.user = Auth.auth().currentUser
                        
                        isLogin = true
                    }
                }
                .padding()
                
                Facebooklogin()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
                
                /*
                Button(action: {
//
//                    let facebookToken = AccessToken.current!.tokenString
//                    let credential = FacebookAuthProvider.credential(withAccessToken: facebookToken)
//                    Auth.auth().signIn(with: credential) { (result, error) in
//                      if let error = error {
//                        printLog("Firebase auth fails with error: \(error.localizedDescription)")
//                      } else if let result = result {
//                        printLog("Firebase login succeeds")
//                      }
//                    }
//                    FacebookLogin()
                    
                }, label: {
                    Image("facebook")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                })
                .frame(width: 50, height: 50, alignment: .center)
//                .onAppear {
//
//                    NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
//
//                        self.user = Auth.auth().currentUser
//                    }
//                }
                .padding()
                 */
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Facebooklogin : UIViewRepresentable {
    func makeCoordinator() -> Facebooklogin.Coordinator {
        return Facebooklogin.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<Facebooklogin>) -> FBLoginButton {

        let button = FBLoginButton()
        button.delegate = context.coordinator
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<Facebooklogin>) {
        
    }

    class Coordinator : NSObject,LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

            if error != nil{

                print((error?.localizedDescription)!)
                return
            }
            if AccessToken.current != nil{

                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)

                Auth.auth().signIn(with: credential) { (res,er) in

                    if er != nil{
                        print((er?.localizedDescription)!)
                        return

                    }
                    print("success")

                }
            }
        }

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
}
