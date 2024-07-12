import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @State private var shouldNavigate: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isEmailValid: Bool = false
    @State private var isCheckingEmail: Bool = false
    
    // State properties for validation
    @State private var emailError: String = ""
    
    // State properties for debounce
    @State private var emailDebounceWorkItem: DispatchWorkItem?
    
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
                
                VStack(alignment: .leading) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal, 20)
                        .onChange(of: email) { _ in
                            debounceEmailValidation()
                        }
                    
                    if !emailError.isEmpty {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.leading, 20)
                    }
                }
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ResetPasswordView().navigationBarBackButtonHidden(false)) {
                        Text("Forgot password?")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .opacity(isEmailValid ? 1.0 : 0.5) // Adjust opacity based on email validity
                            .disabled(!isEmailValid)
                    }
                    .padding(.trailing, 20)
                }
                
                Button(action: {
                    loginUser()
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
                
//                Text("Or continue with")
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Handle continue with Google action
                    }) {
                        HStack {
//                            Image("Google")
//                                .resizable()
//                                .frame(width: 24, height: 24) // Adjust size as needed
//                            Text("Google")
                        }
//                        .font(.headline)
//                        .foregroundColor(.black) // Text color
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.black, lineWidth: 1) // Outline color and width
                        
//                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Handle continue with iCloud action
                    }) {
                        HStack {
//                            Image("Apple")
//                                .resizable()
//                                .frame(width: 24, height: 24) // Adjust size as needed
//                            Text("iCloud")
                        }
//                        .font(.headline)
//                        .foregroundColor(.black)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.black, lineWidth: 1) // Outline color and width
//                        )
//                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding()
            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all)) // Set background color of the screen
        }
    }
    
    private func debounceEmailValidation() {
        emailDebounceWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            validateEmail()
        }
        emailDebounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
    }
    
    private func validateEmail() {
        // Clear previous email error
        emailError = ""
        isEmailValid = false
        
        // Validate email field
        if !isValidEmail(email) {
            emailError = "Invalid email format"
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error checking email: \(error)")
                self.emailError = "Failed to validate email"
                return
            }
            
            if let documents = snapshot?.documents, !documents.isEmpty {
                // Email exists in users collection
                self.isEmailValid = true
            } else {
                self.emailError = "Email not found"
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email) && !email.contains("...")
    }
    
    private func loginUser() {
        validateEmail()
        
        if emailError.isEmpty {
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
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
