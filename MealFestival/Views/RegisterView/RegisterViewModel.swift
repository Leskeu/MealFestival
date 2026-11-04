//
//  RegisterViewModel.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation
import Observation

@Observable
class RegisterViewModel {
  
    var errorMessage = ""
    var successMessage = ""
    private let registerRepository = RegisterRepository()
    
    var registerRequestDTO: RegisterRequestDTO?
    
    
    func validate(name: String,email: String, password: String,confirmPassword: String) -> Bool  {
        errorMessage = ""
        successMessage = ""
        
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
           errorMessage = "Please fill in all the fields."
            return false
        }  
        if name .count < 3 {
             errorMessage = "The password must contain at least 3 characters."
            return false
        }
        if !isValidEmail(email) {
             errorMessage = "Please enter a valid email address."
            return false
            }

        if password.count < 8 {
             errorMessage = "The password must contain at least 8 characters."
            return false
        }

        if password != confirmPassword {
             errorMessage = "The passwords do not match."
            return false
             }
        successMessage = "Registration successful!"
        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(
            of: emailRegex,
            options: .regularExpression
        ) != nil
    }
    
    
    
    func register(name :String,email: String, password: String, confirmPassword : String) async -> UserDTO? {
        guard validate(name: name, email: email, password: password, confirmPassword: confirmPassword) else {
            return nil
        }
           let request = RegisterRequestDTO(
                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
           )
        let user = await registerRepository.register(
            registerResquest: request)
        if user != nil {
            successMessage = "Registration successful!"
        } else {
            errorMessage = "Registration failed. Please try again."
        }
        return user
    }
}
