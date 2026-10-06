//
//  WorkshopCardView.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

struct WorkshopCardView: View {
    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()
            ZStack {
                VStack(alignment:
                        .leading,
                       spacing: 16
                ) {
                    Text(workshop.name)
                        .foregroundStyle(.black)
                        .font(fontMontserrat)
                    HStack {
                        Text(workshop.date.time)
                        Text(workshop.date.day)
                        Text(workshop.date.date)
                    }
                    HStack {
                        Text("<")
                            .font(.title)
                        Text(String(workshop.places)+" "+"places left")
                        Text(workshop.status)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 25,
                                    bottomLeadingRadius: 8,
                                    bottomTrailingRadius: 25,
                                    topTrailingRadius: 8,
                                    style: .continuous
                                )
                                .fill(Color.charcoal)
                            )
                    }
                }
                
                .frame(maxWidth: 350)
                .padding(16)
                .background(.white)
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    WorkshopCardView()
}


struct mockWorkshop {
    let name = "Homemade Burger"
    let date = (time: "19h-20h", day: "Thursday", date: "15 Oct")
    let places = 15
    let status = "Participate"
}

var workshop = mockWorkshop()

let fontMontserrat: Font = Font.custom("Montserrat", size: 18)
