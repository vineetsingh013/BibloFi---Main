//
//  SignUpView.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 04/07/24.

import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phoneNumber: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var shouldNavigateToNewSwift: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 100)

                Text("Create your account")
                    .font(.subheadline)
                    .padding(.bottom, 10)

                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)

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

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)

                TextField("Phone Number", text: $phoneNumber)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.phonePad)
                    .padding(.horizontal, 20)

                Button(action: {
                    async {
                        if password != confirmPassword {
                            self.alertMessage = "Passwords do not match"
                            self.showAlert = true
                            return
                        }

                        do {
                            let _ = try await AuthenticationManager.shared.createUser(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
                            self.shouldNavigateToNewSwift = true // Trigger navigation to NewSwift view
                        } catch {
                            self.alertMessage = "Failed to sign up: \(error.localizedDescription)"
                            self.showAlert = true
                        }
                    }
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#945200"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .disabled(fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || phoneNumber.isEmpty)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sign Up Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                NavigationLink(destination: NewSwift().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToNewSwift) {
                    EmptyView()
                }
                .hidden()

                Spacer()

                NavigationLink(destination: LoginPage().navigationBarBackButtonHidden(true)) {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all)) // Set background color of the screen
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
