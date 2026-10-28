////
////  WorkshopCardDetailView.swift
////  MealFestival
////
////  Created by Filip Rizov on 07/10/2026.
////
//
//import SwiftUI
//
//struct WorkshopCardDetailView: View {
//    let workshop: Workshop
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text(workshop.name)
//                        .foregroundStyle(.black)
//                        .font(.montserrat(.extrabold, size: 20))
//                    Spacer()
//                    Button {
//                        
//                    } label: {
//                        Image("chevron")
//                            .resizable()
//                            .rotationEffect(.degrees(180), anchor: .center)
//                            .frame(width: 30, height: 25)
//                            .padding(.trailing, 10)
//                    }
//                }
//                Text(workshop.categoryName)
//                    .font(.montserrat(.semibold, size: 18))
//                Text(workshop.description)
//                    .font(.montserrat(.regular, size: 16))
//                HStack {
//                    Text(workshop.startTime)
////                    Spacer()
////                    Text(workshop.date.day)
////                        .font(.montserrat(.semibold, size: 18))
////                    Spacer()
////                    Text(workshop.date.date)
//                }
//                HStack(spacing: 0){
//                    Text("\(workshop.totalSubscribers) / \(workshop.maxCapacity)")
//                        .font(.montserrat(.semibold, size: 18))
//                    Text(" "+"spots available")
//                }
//            }
//            .font(.montserrat(.regular, size: 18))
//            .frame(maxWidth: .infinity)
//            .padding(16)
//            Button {
//                
//            } label: {
//                Text("Details")
//                    .foregroundStyle(.white)
//                    .font(.montserrat(.semibold, size: 20))
//                    .padding(.vertical, 8)
//                    .frame(maxWidth: .infinity)
//                    .background(
//                        UnevenRoundedRectangle(
//                            topLeadingRadius: 0,
//                            bottomLeadingRadius: 20,
//                            bottomTrailingRadius: 20,
//                            topTrailingRadius: 0,
//                            style: .continuous
//                        )
////                        .fill(mockVM.buttonColor(workshop.status))
//                    )
//            }
//            .padding([.bottom,.horizontal],2)
//        }
//        .background(
//            UnevenRoundedRectangle(
//                topLeadingRadius: 20,
//                bottomLeadingRadius: 20,
//                bottomTrailingRadius: 20,
//                topTrailingRadius: 20,
//                style: .continuous
//            )
//            .fill(.white)
//        )
//    }
//}
//
//#Preview {
//    let workshop = Workshop(id: UUID(), name: "nom", categoryName: "category", startTime: "startTimeDate", endTime: "endTimeDate", maxCapacity: 12, totalSubscribers: 122, description: "description")
//    
//    
//    WorkshopCardDetailView(workshop: workshop)
//}
