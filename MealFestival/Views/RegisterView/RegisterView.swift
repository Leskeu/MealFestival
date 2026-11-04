//
//  RegisterView.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(RegisterViewModel.self) private var viewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    var body: some View {

        ZStack {

            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 40) {
                
                Image("mealsfestival")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                TextField("name", text: $name)
                    .foregroundStyle(.charcoal)
                    .font(.title3)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .frame(maxWidth : 350)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                TextField("email", text: $email)
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
                TextField("confirm password", text: $confirmPassword)
                    .foregroundStyle(.charcoal)
                    .font(.title3)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .frame(maxWidth: 350)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                }
                
                if !viewModel.successMessage.isEmpty {
                    Text(viewModel.successMessage)
                        .foregroundStyle(.green)
                }
                
                Button() {
                    Task {
                        _ = await viewModel.register(
                            name : name,
                            email: email, 
                            password: password,
                            confirmPassword: confirmPassword
                            
                        )

                    }
                }label: {
                    Text("Register")
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
                }}
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    RegisterView()  
        .environment(RegisterViewModel())
}
