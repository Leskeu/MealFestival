//
//  WorkshopCardView.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

@Observable
class WorkshopCardViewModel {
	@ObservationIgnored
	private let reservationsRepository = ReservationRepository()
	
	func participate(workshopID: UUID, token: String) async -> Bool {
		let createReservationDTO = CreateReservationDTO(workshopID: workshopID)
		return await reservationsRepository.askToParticipate(createReservationDTO: createReservationDTO, token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmF0aW9uIjoxNzkzODg2MDk3Ljg0MjM3NiwiaWQiOiI0QzEwNzA3Qi00NDI1LTRFRTktQUMzRC1BRDFDMkFCNUY0NEYifQ.xpwvTtf6UPKtMGuwnEiWlIh5EjceOY5c_Ch3YYKIBqQ")
	}
	
}


struct WorkshopCardView: View {
	@Environment(UserStore.self) private var userStore

    let workshop: Workshop

	@State var cardVM = WorkshopCardViewModel()
    @State var expanded: Bool = false
	@State var errorMessage: String?
	
	func formatDate(_ isoDate: String, format: String) -> String {
		let isoFormatter = ISO8601DateFormatter()

		guard let date = isoFormatter.date(from: isoDate) else {
			return isoDate
		}

		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "fr_FR")
		formatter.timeZone = TimeZone(identifier: "Europe/Paris")
		formatter.dateFormat = format

		return formatter.string(from: date)
	}
	
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(workshop.name)
                .foregroundStyle(.black)
                .font(.montserrat(.extrabold, size: 20))
				.padding(.horizontal, 8)
				.padding(.top, 8)
            
            if expanded {
                Text(workshop.categoryName)
					.padding(.horizontal, 8)
            }
            
			HStack {
				Text(formatDate(workshop.startTime, format: "HH'h'"))
				Text("-")
				Text(formatDate(workshop.endTime, format: "HH'h'"))
				Spacer()
				Text(formatDate(workshop.startTime, format: "d MMM"))
			}
            .font(.montserrat(.semibold, size: 18))
			.padding(.horizontal, 8)
            
            if expanded {
                Text(workshop.description)
					.padding(.horizontal, 8)
            }
            
			if let errorMessage {
				Text(errorMessage)
			}
			
            HStack {
                Button {
                    expanded.toggle()
                } label: {
                    Image("chevron")
                        .resizable()
						.rotationEffect(Angle(degrees: !expanded ? 180 : 0), anchor: .center)
                        .frame(width: 30, height: 25)
                        .padding(.trailing, 10)
                }
                
                if !expanded {
                    HStack(spacing: 0){
                        Text("\(String(workshop.maxCapacity - workshop.totalSubscribers))")
                            .fontWeight(.semibold)
                        Text(" spots left")
                    }
                    .font(.montserrat(.regular, size: 18))
                } else {
                    HStack(spacing: 0){
                        Text("\(String(workshop.totalSubscribers)) / \(String(workshop.maxCapacity))")
                            .fontWeight(.semibold)
                        Text(" spots available")
                    }
                    .font(.montserrat(.regular, size: 18))
                }
				
				Spacer()
				
				if !expanded {
					Button {
						Task {
							let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmF0aW9uIjoxNzkzODg2MDk3Ljg0MjM3NiwiaWQiOiI0QzEwNzA3Qi00NDI1LTRFRTktQUMzRC1BRDFDMkFCNUY0NEYifQ.xpwvTtf6UPKtMGuwnEiWlIh5EjceOY5c_Ch3YYKIBqQ"
							
							let result = await cardVM.participate(workshopID: workshop.id, token: token)
							
//							if let token = userStore.getToken() {
//								let result = await cardVM.participate(workshopID: workshop.id, token: token)
//								print(result)
//							} else {
//								print("no token")
//							}
						}
					} label: {
						Text("Participate")
							.foregroundStyle(.white)
							.font(.montserrat(.semibold, size: 22))
							.padding(.horizontal, 24)
							.padding(.vertical, 8)
							.kerning(1.8)
							.background(
								UnevenRoundedRectangle(
									topLeadingRadius: 20,
									bottomLeadingRadius: 4,
									bottomTrailingRadius: 20,
									topTrailingRadius: 4,
									style: .continuous
								)
								.fill(.charcoal)
							)
					}
				}
            }
			.padding(8)
			
			if expanded {
				Text("Participate")
					.frame(maxWidth: .infinity)
					.foregroundStyle(.white)
					.font(.montserrat(.semibold, size: 22))
					.padding(.horizontal, 24)
					.padding(.vertical, 8)
					.kerning(1.8)
					.background(
						UnevenRoundedRectangle(
								  topLeadingRadius: 0,
								  bottomLeadingRadius: 14,
								  bottomTrailingRadius: 14,
								  topTrailingRadius: 0,
								  style: .continuous
							  )
							  .fill(.charcoal)
					)
					.padding(2)
			}
        }
        .font(.montserrat(.regular, size: 18))
        .frame(maxWidth: .infinity)
        .background(
			RoundedRectangle(cornerRadius: 14, style: .continuous)
				.fill(.white)
		)
    }
}

#Preview {
    let workshop = Workshop(
        id: UUID(),
        name: "Homemade Burger",
        categoryName: "Street Food",
        startTime: "2026-11-03T14:35:04Z",
        endTime: "2026-11-03T18:35:04Z",
        maxCapacity: 21,
        totalSubscribers: 15,
        description: "Discover our homemade burger workshop : Make your own borger from A to Z with fresh products, delicious sauces and salades. A fun group activity for all ages."
    )
    
    
    ZStack {
        Color.charcoal.ignoresSafeArea()
        WorkshopCardView(workshop: workshop)
			.padding()
			.environment(UserStore())
    }
}
