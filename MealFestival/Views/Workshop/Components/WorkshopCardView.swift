//
//  WorkshopCardView.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

struct WorkshopCardView: View {
    let workshop: Workshop
    
    var body: some View {
        VStack(alignment:
                .leading,
               spacing: 12
        ) {
            Text(workshop.name)
                .foregroundStyle(.black)
                .font(.montserrat(.extrabold, size: 20))
            HStack {
                Text(workshop.startTime)
//                Spacer()
//                Text(workshop.startTime)
//                    .font(.montserrat(.semibold, size: 18))
//                Spacer()
//                Text(workshop.startTime)
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
                    Text(String(workshop.maxCapacity))
                        .font(.montserrat(.semibold, size: 18))
                    Text(" "+"spots left")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.white)
                        .font(.montserrat(.semibold, size: 20))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(
//                            mockVM.buttonForm(workshop.status)
//                                .fill(mockVM.buttonColor(workshop.status))
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
            if true {
                Text("Cancel")
                    .foregroundStyle(.white)
                    .font(.montserrat(.semibold, size: 20))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 24)
                    .padding(.top, 8)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 25,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0,
                            style: .continuous
                        )
                        .fill(.jungle)
                    )
            }
        }
    }
}

#Preview {
    let workshop = Workshop(id: UUID(), name: "nom", categoryName: "category", startTime: "startTimeDate", endTime: "endTimeDate", maxCapacity: 12, totalSubscribers: 122, description: "description")
    
    
    WorkshopCardView(workshop: workshop)
}
