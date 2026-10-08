//
//  WorkshopCardView.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

struct WorkshopCardView: View {
    
    var body: some View {
        VStack(alignment:
                .leading,
               spacing: 12
        ) {
            Text(workshop.name)
                .foregroundStyle(.black)
                .font(.montserrat(.extrabold, size: 20))
            HStack {
                Text(workshop.date.time)
                Spacer()
                Text(workshop.date.day)
                    .font(.montserrat(.semibold, size: 18))
                Spacer()
                Text(workshop.date.date)
            }
            HStack {
                Button {
                    
                } label: {
                    Image("chevron")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .padding(.trailing, 10)
                }
                
                
                HStack(spacing: 0){
                    Text(String(workshop.spots))
                        .font(.montserrat(.semibold, size: 18))
                    Text(" "+"spots left")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text(workshop.status)
                        .foregroundStyle(.white)
                        .font(.montserrat(.semibold, size: 20))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(
                            mockVM.buttonForm(workshop.status)
                                .fill(mockVM.buttonColor(workshop.status))
                        )
                }
            }
        }
        .font(.montserrat(.regular, size: 18))
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(.white)
        .cornerRadius(20)
        .overlay(alignment: .bottomTrailing) {
            if workshop.status == "Reserved" {
                Text(workshop.status)
                    .foregroundStyle(.white)
                    .font(.montserrat(.semibold, size: 20))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 24)
                    .padding(.top, 8)
                    .background(UnevenRoundedRectangle(
                        topLeadingRadius: 25,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 20,
                        topTrailingRadius: 0,
                        style: .continuous
                    )
                        .fill(mockVM.buttonColor(workshop.status))
                    )
            }
        }
    }
}

#Preview {
    ZStack {
        Color.charcoal.ignoresSafeArea()
        WorkshopCardView()
            .padding(16)
    }
}

// mockdata
struct mockWorkshop {
    let name = "Homemade Burger"
    let date = (time: "19h-20h", day: "Thursday", date: "15 Oct")
    let spots = 15
    let maxSpots = 21
    let status = "Participate"
//    let status = "Reserved"
//    let status = "Cancel"
    let category = "Street Food"
    let description = "Discover our homemade burger workshop. Make your own borger from A to Z with fresh products, delicious sauces and salades. A fun group activity for all ages."
}


var workshop = mockWorkshop()

var mockVM = WorkshopViewModel()


let workshops = [ mockWorkshop(),
                  mockWorkshop(),
                  mockWorkshop(),
                  mockWorkshop()
]
