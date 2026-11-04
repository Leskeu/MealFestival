//
//  ContentView.swift
//  MealFestival
//
//  Created by Leskeu  on 15/09/2026.
//

import SwiftUI

// NSSecureTextField a checker pour mdp hidden

struct LoginView: View {
    @Environment(LoginViewModel.self) private var loginVM
    @Environment(UserStore.self) private var userStore
    
    @State private var email:String = "mail@truc.fr"
    @State private var password: String = "bon-mot-de-passe"
    @State private var isSubmitting = false
    
    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 50) {
                Image("mealsfestival")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                VStack(spacing: 20) {
                    TextField("email adress", text: $email)
                        .foregroundStyle(.charcoal)
                        .font(.title3)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .frame(maxWidth : 350)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("password", text: $password)
                        .foregroundStyle(.charcoal)
                        .font(.title3)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .frame(maxWidth: 350)
                        .textInputAutocapitalization(.never)
                }
                
                if let errorMessage = loginVM.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                Button {
                    guard !isSubmitting else { return }
                    isSubmitting = true

                    Task {
                        defer { isSubmitting = false }

                        let token: String? = await loginVM.setLoginRequest(
                            email: email,
                            password: password
                        )

                        if let token = token {
                            if !userStore.setToken(token: token) {
                                loginVM.errorMessage = "Impossible d'enregistrer la session. Réessayez."
                            }
                        }
                    }
                } label: {
                    Text("Login")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background(.jungle)
                        .cornerRadius(20)
                }
                .disabled(isSubmitting)

                NavigationLink {
                    RegisterView()
                } label: {
                    Text("Register")
                }
                .foregroundStyle(.white)
                .font(.title3)
                .disabled(isSubmitting)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environment(LoginViewModel())
    .environment(UserStore())
}
