//
//  ContentView.swift
//  BrainTrainer
//
//  Created by Kristinn Godfrey on 20/08/2020.
//  Copyright © 2020 me.kristinn.godfrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var appState = Bool.random()
    @State private var playerScore = 0
    @State private var currentGame = false
    @State private var round = 1
    
    func textify(state: Bool  ) -> String{
        if state == false {
            return "lose"
        }
        else if state == true {
            return "win"
        }
        else {
            return "lose"
        }
    }
    
    func checkWinner(appMove: String, playerMove: String) -> Bool  {
        if appMove == playerMove {
            return false
        }
        if appMove == "Rock" && playerMove == "Scissors"  {
            if appState == true {
                return true
            }
            else {
                return false
            }
        }
        else if appMove == "Paper" && playerMove == "Rock" {
            if appState == true {
                return true
            }
            else {
                return false
            }
        }
        else if appMove == "Scissors" && playerMove == "Paper" {
            if appState == true {
                return true
            }
            else {
                return false
            }
        }
        if playerMove == "Rock" && appMove == "Scissors"  {
            if appState == false {
                return true
            }
            else {
                return false
            }
        }
        else if playerMove == "Paper" && appMove == "Rock" {
            if appState == false {
                return true
            }
            else {
                return false
            }
        }
        else if playerMove == "Scissors" && appMove == "Paper" {
            if appState == false {
                return true
            }
            else {
                return false
            }
        }
            
        else {
            return false
        }
    }
    func resetGame() {

    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, Color(red: 37, green: 1, blue: 246)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Brain Trainer").font(.largeTitle).foregroundColor(Color.blue).frame(maxWidth: .infinity, maxHeight: 55).background(Color.white).padding(.bottom, 60)
                VStack(alignment: .leading)  {
                    Text("• The app chose \(moves[0])").foregroundColor(.blue)
                    Text("• The app should \(textify(state: appState))").foregroundColor(.blue).padding(.bottom,60)
                }
                
                Section  {
                    Text("Your choice: ")
                        .foregroundColor(Color.blue)
                    
                    
                    
                    ForEach(0 ..< moves.count) { number in
                        Button(action: {
                            if(self.checkWinner(appMove: self.moves[0], playerMove: self.moves[number]) == true) {
                                self.playerScore += 1
                            }
                            self.moves = self.moves.shuffled()
                            self.appState = Bool.random()
                            self.round += 1
                        }) {
                            Text("\(self.moves[number])")
                                .frame(maxWidth: 100, maxHeight: 50)
                                .foregroundColor(Color.blue)
                                .background(Color.white)
                                .cornerRadius(50)
                        }.buttonStyle(PlainButtonStyle())
                    }.padding(3)
                    Text("").padding(.bottom,90)
                }
                
                
                Section {
                    HStack(spacing: 120) {
                        Text("Round: \(round )").foregroundColor(Color.blue)
                        Text("Points: \(playerScore)").foregroundColor(Color.blue)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Color.white)
                    
                }
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
