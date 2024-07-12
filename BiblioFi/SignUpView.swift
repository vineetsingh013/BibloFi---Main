//
//import SwiftUI
//import FirebaseFirestore
//
//struct SignUpView: View {
//    @State private var fullName: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
//    @State private var phoneNumber: String = ""
//    @State private var showAlert: Bool = false
//    @State private var alertMessage: String = ""
//    @State private var shouldNavigateToNewSwift: Bool = false
//    
//    // State properties for validation
//    @State private var fullNameError: String = ""
//    @State private var emailError: String = ""
//    @State private var passwordError: String = ""
//    @State private var confirmPasswordError: String = ""
//    @State private var phoneNumberError: String = ""
//    
//    // State properties for debounce
//    @State private var debounceWorkItem: DispatchWorkItem?
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Welcome")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 100)
//                
//                Text("Create your account")
//                    .font(.subheadline)
//                    .padding(.bottom, 10)
//                
//                VStack(alignment: .leading) {
//                    TextField("Full Name", text: $fullName)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .padding(.horizontal, 20)
//                        .onChange(of: fullName) { _, _ in
//                            debounceValidation(for: .fullName)
//                        }
//                    if !fullNameError.isEmpty {
//                        Text(fullNameError)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.leading, 20)
//                    }
//                }
//                
//                VStack(alignment: .leading) {
//                    TextField("Email", text: $email)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .autocapitalization(.none)
//                        .keyboardType(.emailAddress)
//                        .padding(.horizontal, 20)
//                        .onChange(of: email) { _, _ in
//                            debounceValidation(for: .email)
//                        }
//                    if !emailError.isEmpty {
//                        Text(emailError)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.leading, 20)
//                    }
//                }
//                
//                VStack(alignment: .leading) {
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .padding(.horizontal, 20)
//                        .onChange(of: password) { _, _ in
//                            validatePassword()
//                        }
//                    if !passwordError.isEmpty {
//                        Text(passwordError)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.leading, 20)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                }
//                
//                VStack(alignment: .leading) {
//                    SecureField("Confirm Password", text: $confirmPassword)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .padding(.horizontal, 20)
//                        .onChange(of: confirmPassword) { _, _ in
//                            debounceValidation(for: .confirmPassword)
//                        }
//                    if !confirmPasswordError.isEmpty {
//                        Text(confirmPasswordError)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.leading, 20)
//                    }
//                }
//                
//                VStack(alignment: .leading) {
//                    TextField("Phone Number", text: $phoneNumber)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .keyboardType(.phonePad)
//                        .padding(.horizontal, 20)
//                        .onChange(of: phoneNumber) { _, _ in
//                            debounceValidation(for: .phoneNumber)
//                        }
//                    if !phoneNumberError.isEmpty {
//                        Text(phoneNumberError)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.leading, 20)
//                    }
//                }
//                
//                Button(action: {
//                    signUpUser()
//                }) {
//                    Text("Sign Up")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color(hex: "#945200"))
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 20)
//                .disabled(fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || phoneNumber.isEmpty)
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Sign Up Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                }
//                
//                NavigationLink(destination: NewSwift().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToNewSwift) {
//                    EmptyView()
//                }
//                .hidden()
//                
//                Spacer()
//                
//                NavigationLink(destination: LoginPage().navigationBarBackButtonHidden(true)) {
//                    Text("Already have an account?")
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                }
//                .padding(.bottom, 20)
//            }
//            .padding()
//            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all)) // Set background color of the screen
//        }
//    }
//    
//    private func debounceValidation(for field: ValidationField) {
//        debounceWorkItem?.cancel()
//        let workItem = DispatchWorkItem {
//            switch field {
//            case .fullName:
//                validateFullName()
//            case .email:
//                validateEmail()
//            case .confirmPassword:
//                validateConfirmPassword()
//            case .phoneNumber:
//                validatePhoneNumber()
//            }
//        }
//        debounceWorkItem = workItem
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
//    }
//    
//    private func validateFullName() {
//        if fullName.count > 51 {
//            fullNameError = "Full name cannot be more than 51 characters"
//        } else {
//            let names = fullName.split(separator: " ")
//            if names.count == 1 {
//                fullNameError = ""
//            } else if names.count == 2 {
//                if names[0].lowercased() == names[1].lowercased() {
//                    fullNameError = "First and last names cannot be the same"
//                } else if names[0].count > 25 || names[1].count > 25 {
//                    fullNameError = "Each name cannot exceed 25 characters"
//                } else {
//                    fullNameError = ""
//                }
//            } else {
//                fullNameError = "Full name must contain at most two words"
//            }
//        }
//    }
//    
//    private func validateEmail() {
//        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}(|edu.in)$"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let allowedDomains = ["gmail.com", "yahoo.com", "outlook.com", "icloud.com", "hotmail.com", "aol.com"]
//        if !emailPredicate.evaluate(with: email) {
//            emailError = "Invalid email format"
//        } else if let domain = email.split(separator: "@").last, !allowedDomains.contains(String(domain)) {
//            emailError = "Email must be from a valid provider"
//        } else {
//            // Check if email is already in use
//            let db = Firestore.firestore()
//            db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error checking email: \(error)")
//                    self.alertMessage = "Failed to check email"
//                    self.showAlert = true
//                    return
//                }
//                
//                if snapshot?.isEmpty == false {
//                    self.emailError = "Email already taken"
//                    return
//                }
//                
//                // Clear email error if no issues found
//                self.emailError = ""
//            }
//        }
//    }
//    
//    private func validatePassword() {
//        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^\\da-zA-Z]).{8,}$"
//        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        if !passwordPredicate.evaluate(with: password) {
//            passwordError = "Password must be at least 8 characters, with at least one special character, one uppercase letter, and one lowercase letter"
//        } else {
//            passwordError = ""
//        }
//    }
//    
//    private func validateConfirmPassword() {
//        if confirmPassword != password {
//            confirmPasswordError = "Passwords do not match"
//        } else {
//            confirmPasswordError = ""
//        }
//    }
//    
//    private func validatePhoneNumber() {
//        let phoneRegEx = "^[0-9]{10}$"
//        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
//        if !phonePredicate.evaluate(with: phoneNumber) {
//            phoneNumberError = "Phone number must be exactly 10 digits"
//        } else {
//            phoneNumberError = ""
//        }
//    }
//    
//    private func signUpUser() {
//        validateFullName()
//        validateEmail()
//        validatePassword()
//        validateConfirmPassword()
//        validatePhoneNumber()
//        
//        if !fullNameError.isEmpty || !emailError.isEmpty || !passwordError.isEmpty || !confirmPasswordError.isEmpty || !phoneNumberError.isEmpty {
//            alertMessage = "Please correct the errors"
//            showAlert = true
//            return
//        }
//        
//        if password != confirmPassword {
//            alertMessage = "Passwords do not match"
//            showAlert = true
//            return
//        }
//        
//        // Check if email error is still empty (i.e., no validation errors)
//        if emailError.isEmpty {
//            Task {
//                do {
//                    let _ = try await AuthenticationManager.shared.createUser(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
//                    shouldNavigateToNewSwift = true // Trigger navigation to NewSwift view
//                } catch {
//                    alertMessage = "Failed to sign up: \(error.localizedDescription)"
//                    showAlert = true
//                }
//            }
//        } else {
//            // Show alert for email validation error
//            showAlert = true
//        }
import FirebaseFirestore
import SwiftUI

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var shouldNavigateToNewSwift: Bool = false
    
    // State properties for validation
    @State private var firstNameError: String = ""
    @State private var lastNameError: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var phoneNumberError: String = ""
    
    // State properties for debounce
    @State private var debounceWorkItem: DispatchWorkItem?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)

                    Text("Create your account")
                        .font(.subheadline)
                        .padding(.bottom, 5)

                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("First Name", text: $firstName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.horizontal, 25)
                                .onChange(of: firstName) { _ in
                                    debounceValidation(for: .firstName)
                                }

                            if !firstNameError.isEmpty {
                                Text(firstNameError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.leading, 25) // Adjust padding as needed
                                    .lineLimit(nil) // Allows the text to wrap as needed
                            }

                        }

                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Last Name", text: $lastName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.horizontal, 25)
                                .onChange(of: lastName) { _ in
                                    debounceValidation(for: .lastName)
                                }

                            if !lastNameError.isEmpty {
                                Text(lastNameError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.leading, 25)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding(.horizontal, 25)
                                .onChange(of: email) { _ in
                                    debounceValidation(for: .email)
                                }

                            if !emailError.isEmpty {
                                Text(emailError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.leading, 25)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.horizontal, 25)
                                .onChange(of: password) { _ in
                                    validatePassword()
                                }

                            if !passwordError.isEmpty {
                                Text(passwordError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.leading, 25)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Phone Number", text: $phoneNumber)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .keyboardType(.phonePad)
                                .padding(.horizontal, 20)
                                .onChange(of: phoneNumber) { _ in
                                    debounceValidation(for: .phoneNumber)
                                }

                            if !phoneNumberError.isEmpty {
                                Text(phoneNumberError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.leading, 20)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }

                    Button(action: {
                        signUpUser()
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
                    .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Sign Up Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink(destination: NewSwift().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToNewSwift) {
                        EmptyView()
                    }
                    .hidden()

                    NavigationLink(destination: LoginPage()) {
                        Text("Already have an account?")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                

                }
                .padding()

            }
            .onTapGesture {
                hideKeyboard()
            }
            .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all))
        }
    }

    
    private func debounceValidation(for field: ValidationField) {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            switch field {
            case .firstName, .lastName:
                validateFullName()
            case .email:
                validateEmail()
            case .phoneNumber:
                validatePhoneNumber()
            }
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem) // Adjust debounce delay as needed
    }
    
    private func validateFullName() {
        let firstNameLimit = 25
        let lastNameLimit = 25
        
        // Split the firstName and lastName by whitespace
        let firstNameWords = firstName.split(separator: " ")
        let lastNameWords = lastName.split(separator: " ")

        // Validate firstName
        if firstName.isEmpty {
            firstNameError = "First name cannot be empty"
        } else if firstName.count > firstNameLimit {
            firstNameError = "First name cannot exceed \(firstNameLimit) characters"
        } else if firstNameWords.count > 1 {
            firstNameError = "First name should contain only one word"
        } else {
            firstNameError = ""
        }
        
        // Validate lastName
        if lastName.isEmpty {
            lastNameError = "Last name cannot be empty"
        } else if lastName.count > lastNameLimit {
            lastNameError = "Last name cannot exceed \(lastNameLimit) characters"
        } else if lastNameWords.count > 2 {
            lastNameError = "Last name should contain no more than two words"
        } else if lastNameWords.count == 2 && lastNameWords[0].lowercased() == lastNameWords[1].lowercased() {
            lastNameError = "Last name words cannot be the same"
        } else {
            lastNameError = ""
        }

        // Validate that firstName and lastName cannot be the same
        if firstName.lowercased() == lastName.lowercased() {
            firstNameError = "First name and last name cannot be the same"
            lastNameError = "First name and last name cannot be the same"
        } else if firstNameError.isEmpty && lastNameError.isEmpty {
            firstNameError = ""
            lastNameError = ""
        }
    }
    
    private func validateEmail() {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let allowedDomains = ["gmail.com", "yahoo.com", "outlook.com", "icloud.com", "hotmail.com", "aol.com"]
        
        if email.isEmpty {
            emailError = "Email cannot be empty"
        } else if !emailPredicate.evaluate(with: email) {
            emailError = "Invalid email format"
        } else if let domain = email.split(separator: "@").last, !allowedDomains.contains(String(domain)) {
            emailError = "Email must be from a valid provider"
        } else {
            // Check if email is already in use
            let db = Firestore.firestore()
            db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
                if let error = error {
                    print("Error checking email: \(error)")
                    self.alertMessage = "Failed to check email"
                    self.showAlert = true
                    return
                }
                
                if snapshot?.isEmpty == false {
                    self.emailError = "Email already taken"
                } else {
                    self.emailError = ""
                }
            }
        }
    }
    
    private func validatePassword() {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^\\da-zA-Z]).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        if password.isEmpty {
            passwordError = "Password cannot be empty"
        } else if !passwordPredicate.evaluate(with: password) {
            passwordError = "Password: 8+ characters, 1 special, 1 uppercase, 1 lowercase."
        } else {
            passwordError = ""
        }
    }
    
    private func validatePhoneNumber() {
        let phoneRegEx = "^[0-9]{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        
        if phoneNumber.isEmpty {
            phoneNumberError = "Phone number cannot be empty"
        } else if !phonePredicate.evaluate(with: phoneNumber) {
            phoneNumberError = "Phone number must be exactly 10 digits"
        } else {
            phoneNumberError = ""
        }
    }
    
    private func signUpUser() {
        validateFullName()
        validateEmail()
        validatePassword()
        validatePhoneNumber()
        
        if !firstNameError.isEmpty || !lastNameError.isEmpty || !emailError.isEmpty || !passwordError.isEmpty || !phoneNumberError.isEmpty {
            alertMessage = "Please correct the errors"
            showAlert = true
            return
        }
        
        // Proceed with signing up the user
        // Example: Directly navigate or perform sign up logic
        
        // For demonstration, navigating to a new view after successful sign-up
        shouldNavigateToNewSwift = true
    }
}

enum ValidationField {
    case firstName, lastName, email, phoneNumber
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
