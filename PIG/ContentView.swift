//
//  ContentView.swift
//  PIG
//
//  Created by Betzy Moreno on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var turnScore = 0
    @State private var gameScore = 0
    @State private var randomValue = 0
    @State private var rotation = 0.0
    func endTurn () {
        turnScore = 0
        randomValue = 0
    }
    func chooserandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                randomValue = Int.random(in: 1...6)
                chooserandom(times: times - 1)
            }
        }
        if times == 0 {
            if randomValue == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    endTurn()
                }
            }
            else {
                turnScore += randomValue
            }
        }
    }
    var body: some View {
        NavigationView(){
            ZStack {
                Color.gray.opacity(0.7).ignoresSafeArea()
                VStack {
                    Image("Pig").resizable().frame(width: 150, height: 150)
                    CustomText(text: "Pig")
                    Image("pips \(randomValue)")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .rotationEffect(.degrees(rotation))
                        .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                        .padding(50)
                    Spacer()
                    CustomText(text: "Turn Score: \(turnScore)")
                    HStack {
                        Button("Roll") {
                            chooserandom(times: 3)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                        Button("Hold") {
                            gameScore += turnScore
                            endTurn()
                            withAnimation(.easeInOut(duration: 1)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    CustomText(text: "Game Score: \(gameScore)")
                    NavigationLink("How to play", destination: InstuctionsView())
                        .font(Font.custom("Marker Felt", size: 24))
                        .padding()
                    Spacer()
                }
            }
        }
    }
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 36))
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50)
            .font(Font.custom("Marker Felt", size: 24))
            .padding()
            .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct InstuctionsView: View {
    var body: some View {
            ZStack {
                Color.gray.opacity(0.7).ignoresSafeArea()
                VStack {
                    Image("Pig").resizable().frame(width: 150, height: 150)
                    Text("Pig").font(.title)
                    VStack (alignment: .leading){
                        Text("In the game of pig, players take indivial turns. Each turn, a player repeatedly rolls in a single die until either a pig is rolled or the player decides to \"hold\".")
                            .padding()
                        Text("If the player rolls a Pig, they score nothing, and it becomes the next player's turn.")
                            .padding()
                        Text("If the player rolls any other number, it is added to their turn total, and the player's turn continues.")
                            .padding()
                        Text("If a player choose to \"hold\", their turn total is added to their game score, and it becomes the next player's turn.")
                            .padding()
                        Text("A player wins the game when the game score becomes 100 or more on their turn.")
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
