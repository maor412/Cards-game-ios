//
//  ResultsView.swift
//  CardsGame
//

import SwiftUI

struct ResultsView: View {

    var winner:String
    var score:Int
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Winner:")
                    Text(winner)
                }
                
                HStack {
                    Text("Score:")
                    Text("\(String(score))")
                }
                Button(action: {
                    
                        }) {
                            Text("BACK TO MENU")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding()
                        }
            
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(winner: "Test", score: 0)
    }
}
