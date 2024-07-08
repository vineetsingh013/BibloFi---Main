//
//  LoginPage.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 04/07/24.
//

//last working


//import SwiftUI
//import FirebaseAuth
//
//struct LoginPage: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
//    @State private var shouldNavigate: Bool = false
//    @State private var showAlert: Bool = false
//    @State private var alertMessage: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Welcome")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 100)
//
//                Text("Please login to your account")
//                    .font(.subheadline)
//                    .padding(.bottom, 40)
//
//                TextField("Email", text: $email)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .autocapitalization(.none)
//                    .keyboardType(.emailAddress)
//                    .padding(.horizontal, 20)
//
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .padding(.horizontal, 20)
//
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Handle forget password action
//                    }) {
//                        Text("Forgot password?")
//                            .font(.footnote)
//                            .foregroundColor(.blue)
//                    }
//                    .padding(.trailing, 20)
//                }
//
//                Button(action: {
//                    async {
//                        do {
//                            let authResult = try await AuthenticationManager.shared.loginUser(email: email, password: password)
//                            print("Successfully signed in user with uid: \(authResult.uid)")
//                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                            print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
//                            self.shouldNavigate = true // Trigger navigation
//                        } catch {
//                            print("Failed to sign in: \(error.localizedDescription)")
//                            self.alertMessage = "Email or password is incorrect"
//                            self.showAlert = true
//                        }
//                    }
//                }) {
//                    Text("Login")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color(hex: "#945200"))
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 20)
//                .disabled(email.isEmpty || password.isEmpty)
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                }
//
//                NavigationLink(destination: NewSwift().navigationBarBackButtonHidden(true), isActive: $shouldNavigate) {
//                    EmptyView()
//                }
//                .hidden()
//
//                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
//                    Text("Create new account")
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                }
//                .padding(.trailing, 20)
//
//                Text("Or continue with")
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
//
//                HStack(spacing: 20) {
//                    Button(action: {
//                        // Handle continue with Google action
//                    }) {
//                        HStack {
//                            Image("Google")
//                                .resizable()
//                                .frame(width: 24, height: 24) // Adjust size as needed
//                            Text("Google")
//                        }
//                        .font(.headline)
//                        .foregroundColor(.black) // Text color
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.black, lineWidth: 1) // Outline color and width
//                        )
//                        .cornerRadius(8)
//                    }
//
//                    Button(action: {
//                        // Handle continue with iCloud action
//                    }) {
//                        HStack {
//                            Image("Apple")
//                                .resizable()
//                                .frame(width: 24, height: 24) // Adjust size as needed
//                            Text("iCloud")
//                        }
//                        .font(.headline)
//                        .foregroundColor(.black)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.black, lineWidth: 1) // Outline color and width
//                        )
//                        .cornerRadius(8)
//                    }
//                }
//                .padding(.horizontal, 20)
//
//                Spacer()
//            }
//            .padding()
//            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all)) // Set background color of the screen
//        }
//    }
//}
//
////extension Color {
////    init(hex: String) {
////        let scanner = Scanner(string: hex)
////        _ = scanner.scanString("#")
////
////        var rgbValue: UInt64 = 0
////        scanner.scanHexInt64(&rgbValue)
////
////        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
////        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
////        let blue = Double(rgbValue & 0x0000ff) / 255.0
////
////        self.init(red: red, green: green, blue: blue)
////    }
////}
//
//struct LoginPage_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginPage()
//    }
//}


import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @State private var shouldNavigate: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 100)
                
                Text("Please login to your account")
                    .font(.subheadline)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ResetPasswordView().navigationBarBackButtonHidden(true)) {
                        Text("Forgot password?")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 20)
                }
                
                Button(action: {
                    async {
                        do {
                            let authResult = try await AuthenticationManager.shared.loginUser(email: email, password: password)
                            print("Successfully signed in user with uid: \(authResult.uid)")
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
                            self.shouldNavigate = true // Trigger navigation
                        } catch {
                            print("Failed to sign in: \(error.localizedDescription)")
                            self.alertMessage = "Email or password is incorrect"
                            self.showAlert = true
                        }
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#945200"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .disabled(email.isEmpty || password.isEmpty)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                NavigationLink(destination: NewSwift().navigationBarBackButtonHidden(true), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                    Text("Create new account")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 20)
                
                Text("Or continue with")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Handle continue with Google action
                    }) {
                        HStack {
                            Image("Google")
                                .resizable()
                                .frame(width: 24, height: 24) // Adjust size as needed
                            Text("Google")
                        }
                        .font(.headline)
                        .foregroundColor(.black) // Text color
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1) // Outline color and width
                        )
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Handle continue with iCloud action
                    }) {
                        HStack {
                            Image("Apple")
                                .resizable()
                                .frame(width: 24, height: 24) // Adjust size as needed
                            Text("iCloud")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1) // Outline color and width
                        )
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding()
            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all)) // Set background color of the screen
        }
    }
}

//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        _ = scanner.scanString("#")
//
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//
//        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
//        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
//        let blue = Double(rgbValue & 0x0000ff) / 255.0
//
//        self.init(red: red, green: green, blue: blue)
//    }
//}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
