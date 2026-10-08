//
//  RegisterView.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

//import SwiftUI
//
//struct RegisterView: View {
//    @State private var viewModel = RegisterViewModel()
//    
//    var body: some View {
//        ZStack{
//            Color.charcoal.ignoresSafeArea()
//            VStack(alignment: .center, spacing: 40){
//                Image("mealsfestival")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: 300)
//                
//                TextField("Email", text: $viewModel.email)
//                    .keyboardType(.emailAddress)
//                    .autocorrectionDisabled()
//                    .textFieldStyle(.roundedBorder)
//    
//                TextField("Mot de passe",text: $viewModel.password)
//                    .textFieldStyle(.roundedBorder)
//                
//                TextField("Confirmer le mot de passe",text: $viewModel.confirmPassword)
//                    .textFieldStyle(.roundedBorder)
//            
//                Button("Register") {
//                   viewModel.validate() 
//                }
//                .foregroundStyle(.white)
//                .font(.title3)
//                .padding(.horizontal, 50)
//                .padding(.vertical, 20)
//                .background(
//                    UnevenRoundedRectangle(
//                        topLeadingRadius: 70,
//                        bottomLeadingRadius: 20,
//                        bottomTrailingRadius: 70,
//                        topTrailingRadius: 20
//                    )
//                    .fill(.jungle)
//                )
//            }      
//            .padding(.horizontal, 20)  
//        }
//        
//    }
//}
//#Preview {
//    RegisterView()
//}
import SwiftUI

struct RegisterView: View {

    @State private var viewModel = RegisterViewModel()

    var body: some View {

        ZStack {

            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 40) {

                Image("mealsfestival")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)

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
                    viewModel.validate()
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
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    RegisterView()
}
