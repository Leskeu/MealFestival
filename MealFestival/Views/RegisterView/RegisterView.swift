//
//  RegisterView.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(UserStore.self) private var userStore

    @State private var viewModel = RegisterViewModel()
    @State private var isSubmitting = false

    var body: some View {

        ZStack {

            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 40) {

                Image("mealsfestival")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                TextField("Name", text: $viewModel.name)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                SecureField(
                    "Confirm password",
                    text: $viewModel.confirmPassword
                )
                .textFieldStyle(.roundedBorder)

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                }

                if !viewModel.successMessage.isEmpty {
                    Text(viewModel.successMessage)
                        .foregroundStyle(.green)
                }

                Button("Register") {
                    guard !isSubmitting else { return }
                    isSubmitting = true

                    Task {
                        defer { isSubmitting = false }

                        let token: String? = await viewModel.setRegisterRequest()

                        if let token = token {
                            if !userStore.setToken(token: token) {
                                viewModel.errorMessage = "Impossible d'enregistrer la session. Réessayez."
                            }
                        }
                    }
                }
                .foregroundStyle(.white)
                .font(.title3)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 70,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 70,
                        topTrailingRadius: 20
                    )
                    .fill(.jungle)
                )
                .disabled(isSubmitting)

                Button("Login") {
                    dismiss()
                }
                .foregroundStyle(.white)
                .font(.title3)
                .disabled(isSubmitting)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(isSubmitting)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
    .environment(UserStore())
}
