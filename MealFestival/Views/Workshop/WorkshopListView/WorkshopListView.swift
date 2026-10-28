
import SwiftUI

struct WorkshopListView: View {
    @Environment(WorkshopRepository.self) private var workshopRepository
    @Environment(UserRepository.self) private var userRepository

    @State private var workshops: [Workshop] = []
    @State private var token: UserToken?
    
    
    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text("Workshops")
                    .font(.custom("Montserrat-ExtraBold", size: 40))
                    .foregroundStyle(.white)

                ScrollView {
                    ForEach(workshops) { wk in
                        WorkshopCardView(workshop: wk)
                    }
                }
            }
            .padding()
        }
        .task {
            if let token = await userRepository.getToken(loginRequestDTO: LoginRequestDTO(email: "mail@truc.fr", password: "mauvais-mot-de-passe")) {
                workshops = await workshopRepository.getReservedWorkshopFromUser(userToken: token)
                print(token)
            } else {
                workshops = await workshopRepository.getWorkshops()
            }

            print(workshops)
        }
    }
}

#Preview {
    NavigationStack {
        WorkshopListView()
    }
    .environment(UserRepository())
    .environment(WorkshopRepository())
}
