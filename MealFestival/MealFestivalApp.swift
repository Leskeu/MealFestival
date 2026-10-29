//
//  MealFestivalApp.swift
//  MealFestival
//
//  Created by Leskeu  on 15/09/2026.
//

import SwiftUI

@main
struct MealFestivalApp: App {

    @State private var userStore = UserStore()
    @State private var loginVM = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if userStore.token != nil {
                    NavigationStack {
                        WorkshopListView()
                    }
                } else {
                    LoginView()
                }
            }
            .environment(userStore)
            .environment(loginVM)
        }
    }
}
