import Foundation
import Observation

@Observable
class LoginViewModel {

    var loginRequest: LoginRequestDTO?
    var errorMessage: String?
    private var userRepository: UserRepository = UserRepository()

    func validate(email: String, password: String) -> Bool {

        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !email.isEmpty else {
            errorMessage = "L'email est obligatoire"
            return false
        }
        
        guard !password.isEmpty else {
            errorMessage = "Le mot de passe est obligatoire"
            return false
        }

        guard email.contains("@"), email.contains(".") else {
            errorMessage = "L'adresse email est invalide"
            return false
        }

        errorMessage = nil
        return true
    }

    func setLoginRequest(email: String, password: String) async -> String? {
        if validate(email: email, password: password) {
            loginRequest = LoginRequestDTO(
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
            
            if let token = await self.userRepository.getToken(loginRequestDTO: loginRequest!) {
                return token.token
            } else {
                errorMessage = "Connexion refused"
            }
        }
        
        return nil
    }
}
