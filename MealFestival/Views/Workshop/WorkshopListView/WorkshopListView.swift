//
//  WorkshopListView.swift
//  MealFestival
//
//  Created by Leskeu  on 07/10/2026.
//

import SwiftUI
import UIKit

struct WorkshopListView: View {
    
    
    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Workshops")
                    .font(.custom("Montserrat-ExtraBold", size: 40))
                    .foregroundStyle(.white)
                ScrollView {
                    ForEach(workshops.indices, id: \.self) { index in
                        WorkshopCardView()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        WorkshopListView()
    }
}
