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

    var email = ""
    var password = ""
    var confirmPassword = ""
    var errorMessage = ""
    var successMessage = ""

    func validate() {
        errorMessage = ""
        successMessage = ""

        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            return errorMessage = "Please fill in all the fields."
          
        }    
        if !isValidEmail(email) {
            return errorMessage = "Please enter a valid email address."
            }

        if password.count < 8 {
            return errorMessage = "The password must contain at least 8 characters."
            }

        if password != confirmPassword {
            return errorMessage = "The passwords do not match."
             }
        successMessage = "Registration successful!"
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(
            of: emailRegex,
            options: .regularExpression
        ) != nil
    }
}
