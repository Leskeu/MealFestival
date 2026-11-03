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
    var name = "Juless"
    var email = "julesliegeois@gmail.com"
    var password = "jules123"
    var confirmPassword = "jules123"
    var errorMessage = ""
    var successMessage = ""
    
    private var registerRequest: RegisterRequestDTO?
    
    private var userRepository: UserRepository = UserRepository()

    func validate() -> Bool {
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

        if password.count < 4 {
            errorMessage = "The password must contain at least 4 characters."
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
    
    func setRegisterRequest() async -> String? {
        if validate() {
            registerRequest = RegisterRequestDTO(
                email: self.email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: self.password,
                name: self.name
            )
            
            print(registerRequest!)
            
            if let token = await self.userRepository.registerUser(registerRequest: registerRequest!) {
                return token.token
            } else {
                errorMessage = "Can't register, try again"
            }
        }
        
        return nil
    }
}
