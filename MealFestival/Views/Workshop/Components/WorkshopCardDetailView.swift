//
//  WorkshopCardDetailView.swift
//  MealFestival
//
//  Created by Filip Rizov on 07/10/2026.
//

import SwiftUI

struct WorkshopCardDetailView: View {
    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                VStack(alignment:
                        .leading,
                       spacing: 12
                ) {
                    HStack {
                        Text(workshop.name)
                            .foregroundStyle(.black)
                            .font(.montserrat(.extrabold, size: 20))
                        Spacer()
                            Button {
                                
                            } label: {
                                Image("chevron")
                                    .resizable()
                                    .rotationEffect(.degrees(180), anchor: .center)
                                    .frame(width: 30, height: 25)
                                    .padding(.trailing, 10)
                            }
                    }
                    Text(workshop.category)
                    
                        .font(.montserrat(.semibold, size: 18))
                    Text(workshop.description)
                        .font(.montserrat(.regular, size: 16))
                    HStack {
                        Text(workshop.date.time)
                        Spacer()
                        Text(workshop.date.day)
                            .font(.montserrat(.semibold, size: 18))
                        Spacer()
                        Text(workshop.date.date)
                    }
                        HStack(spacing: 0){
                            Text(String(workshop.spots)+" / "+String(workshop.maxSpots))
                                .font(.montserrat(.semibold, size: 18))
                            Text(" "+"spots available")
                        }
                        .padding(.bottom, 48)
                    // where button was in card view, padding on the text leaves space for the button in the z stack
                }
                .font(.montserrat(.regular, size: 18))
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(.white)
                .cornerRadius(20)
                // button is in z stack; but not insite the white, but on top of it
                Button {
                    
                } label: {
                    Text(workshop.status)
                        .foregroundStyle(.white)
                        .font(.montserrat(.semibold, size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 20,
                                topTrailingRadius: 0,
                                style: .continuous
                            )
                            .fill(Color.jungle)
                        )
                }
                .padding(.bottom, 2)
                .padding(.horizontal, 2)
                
            }
            .padding(16)
        }
    }
}

#Preview {
    WorkshopCardDetailView()
}
