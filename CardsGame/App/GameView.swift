//
//  GameView.swift
//  CardsGame
//

import SwiftUI

struct GameView: View {

    var location: String
    @AppStorage("PlayerName") var playerName: String = "No Name"
    @State private var playerCard: Card = Card(image:"back", value:0)
    @State private var pcCard:Card = Card(image:"back", value:0)
    @State private var playerScore: Int = 0
    @State private var pcScore:Int = 0
    @State private var currentRound: Int = 0
    @State private var time: Int = 5
    @State private var timer: Timer?
    @State private var delay: Int = 2
    @State private var showResults:Bool = false
    @State private var winnerName:String = ""
    @State private var winnerScore:Int = 0
    private let timerInterval: TimeInterval = 1.0
    private let MaxRounds:Int = 10
    
    
    var body: some View {
        NavigationView {
            if location == "Left" {
                HStack {
                    VStack {
                        Text(playerName)
                        Text("\(String(playerScore))")
                        Image(playerCard.image).resizable().scaledToFit()
                    }.padding()
                    
                    Spacer()
                    VStack{
                        Image(systemName: "timer")
                              .font(.system(size: 25))
                              .padding(2)

                        Text("5")
                              .font(.title2)
                    }
                    Spacer()
                    
                    VStack {
                        Text("PC")
                        Text("\(String(pcScore))")
                        Image("back").resizable().scaledToFit()
                    }.padding()
                }
            }else {
                HStack {
                    VStack {
                        Text("PC")
                        Text("\(String(pcScore))")
                        Image(pcCard.image).resizable().scaledToFit()
                    }.padding()
                    
                    Spacer()
                    VStack{
                        Image(systemName: "timer")
                              .font(.system(size: 25))
                              .padding(2)

                        Text("\(String(time))")
                              .font(.title2)
                    }
                    Spacer()
                 
                    
                    VStack {
                        Text(playerName)
                        Text("\(String(playerScore))")
                        Image(playerCard.image).resizable().scaledToFit()
                    }.padding()
                }
            }
            
                
        }
        .background( NavigationLink(destination: ResultsView(winner: winnerName, score: winnerScore), isActive: $showResults) {
            EmptyView()
        })
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        
    }
    
    private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
                // Perform the action you want to execute every 5 seconds
                if time > 0 {
                    time -= 1
                }else {
                    if currentRound == MaxRounds {
                        // game finish
                        if pcScore > playerScore {
                            winnerName = "PC"
                            winnerScore = pcScore
                        }else {
                            winnerName = playerName
                            winnerScore = playerScore
                        }
                        showResults = true
                    }else {
                        // wait 2 sec between rounds
                        if delay == 0 {
                            delay = 2
                            time = 5
                            currentRound += 1
                            playerCard = cardsData.randomElement() ?? Card(image: "back", value: 0)
                            pcCard = cardsData.randomElement() ?? Card(image: "back", value: 0)
                            
                            if playerCard.value > pcCard.value {
                                playerScore += 1
                            }else if playerCard.value < pcCard.value {
                                pcScore += 1
                            }
                        }else {
                            delay -= 1
                            playerCard = Card(image: "back", value: 0)
                            pcCard = Card(image: "back", value: 0)
                            
                        }
                    }
                }
               
                
            }
        }

        private func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(location: "Left")
    }
}
