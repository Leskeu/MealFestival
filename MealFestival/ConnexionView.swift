//
//  ContentView.swift
//  MealFestival
//
//  Created by Leskeu  on 15/09/2026.
//

import SwiftUI

// NSSecureTextField a checker pour mdp hidden

struct ConnexionView: View {
    @State private var username:String = ""
    @State private var password: String = ""
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
                    TextField("email adress", text: $username)
                        .foregroundStyle(.charcoal)
                        .font(.title3)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .frame(maxWidth : 350)
                    TextField("password", text: $password)
                        .foregroundStyle(.charcoal)
                        .font(.title3)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .frame(maxWidth: 350)
                }
                Text("Login")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .background(.jungle)
                    .cornerRadius(20)
                Text("Register")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    ConnexionView()
}
