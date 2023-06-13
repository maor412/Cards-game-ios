import SwiftUI
import CoreLocation

struct ContentView: View {
    private let centerPointLat: CLLocationDegrees = 34.817549168324334

    @StateObject private var locationManager = LocationManager()
    @State private var isShowingDialog: Bool = false
    @State private var isShowingGame: Bool = false
    @State private var inputText: String = ""
    @AppStorage("PlayerName") var playerName: String = ""

    private var sideLocation: String {
        if let location = locationManager.lastLocation {
            if location.coordinate.latitude < centerPointLat {
                return "Left"
            } else {
                return "Right"
            }
        } else {
            return "Unknown"
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if sideLocation == "Left" || sideLocation == "Unknown" {
                        // left image
                        Image("LeftEarth")
                    }
                    Spacer()
                    VStack {
                        // Enter name button
                        Button(action: {
                            isShowingDialog = true
                        }) {
                            Text("Insert Name")
                        }
                        .sheet(isPresented: $isShowingDialog) {
                            VStack {
                                TextField("Enter Your Name", text: $inputText)
                                    .padding()
                                
                                Button("OK") {
                                    isShowingDialog = false
                                    playerName = inputText
                                }
                            }
                        }
                        // Player Name
                        Text(playerName)
                            .padding()
                      
                        NavigationLink(destination: GameView(location: sideLocation)) {
                           
                            Text("Start Game")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding()
                            
                        }
                       
                    }
                    Spacer()
                    if sideLocation == "Right" || sideLocation == "Unknown"  {
                        // right image
                        Image("RightEarth")
                    }
                }
            }
            
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
