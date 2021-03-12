//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kristinn Godfrey on 14/08/2020.
//  Copyright © 2020 me.kristinn.godfrey. All rights reserved.
//

import SwiftUI

extension Image {
    func FlagStyle() -> some View  {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreText = ""
    @State private var userScore = 0
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Text("")
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        
                    
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.opacityAmount = 0.25
                    }) {
                        Image(self.countries[number])
                            .FlagStyle()
                    }
                    .opacity(number == self.correctAnswer  ? 1 : self.opacityAmount)
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                }
                Text("Score: \(userScore)")
                Spacer()
            }
            
                .foregroundColor(.white )
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("\(scoreText)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
            }
        }
    }
    func flagTapped(_ number: Int) {
        
    if number == correctAnswer {
        scoreTitle = "Correct"
        scoreText = "Good job"
        userScore += 1
        

        withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
            self.animationAmount += 360
        }
        
        } else {
            scoreTitle = "Wrong"
        scoreText = "The flag you pressed is \(countries[number])"
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation(.easeInOut) {
            self.opacityAmount = 1.0
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}
