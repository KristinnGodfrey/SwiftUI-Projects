//
//  ContentView.swift
//  Edutainment
//
//  Created by Kristinn Godfrey on 02/09/2020.
//  Copyright © 2020 me.kristinn.godfrey. All rights reserved.
//

import SwiftUI

struct Question {
    var text: String
    var answer: Int
    
}



struct ContentView: View {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 126 / 255, green: 206 / 255, blue: 144 / 255, alpha: 1.0)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    @State private var gameStarted = false
    @State private var multiplicationNum = 1
    @State private var questionNum = "5"
    @State private var imgs = ["chick", "bear", "frog", "giraffe", "snake"]
    let mults = [1,2,3,4,5,6,7,8,9,10,11,12]
    let variantsOfQuestions = ["5", "10", "20", "All"]
    let randomInt = Int.random(in: 0..<12)
    @State private var arrayOfQuestions = [Question]()
    @State private var currentQuestion = 0
    
    @State private var totalScore = 0
    @State private var remainingQuestions = 0
    @State private var selectedNumber = 0
    
    @State private var  isCorrect = false
    @State private var isWrong = false

    @State private var isShowAlert = false
    @State private var  alertTitle = ""
    @State private var buttonAlertTitle = ""

    @State private var isWinGame = false
    
    @State private var answerArray = [Question]()
    
    var body: some View {
        
        return Group {
            NavigationView {
                ZStack {
                    Color(red: 126 / 255, green: 206 / 255, blue: 144 / 255)
                    .edgesIgnoringSafeArea(.all)
                    if gameStarted {
                        VStack{
                            HStack{
                                Spacer()
                            }
                            Text("\(arrayOfQuestions[currentQuestion].text)?")
                            VStack {
                                ForEach (0 ..< 4,id: \.self) { number in
                                    HStack {
                                        Button(action: {
                                            if(self.remainingQuestions == 1)
                                            {
//                                                Alert(title: Text("\(self.alertTitle)"), message: Text("You score is: \(self.totalScore)"), dismissButton: .default(Text("\(self.buttonAlertTitle)")))
                                                self.newGame()
                                                self.gameStarted = false
                                            }
                                            self.checkAnswer(number)
                                        }){
                                            Image(self.imgs[number]).resizable()
                                                .frame(width:60, height:55)
                                            Text("\(self.answerArray[number].answer)")
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            Spacer()
                            Button("Exit game") {
                                self.gameStarted = false
                            }
                                
                            .padding(10)
                            .background(Color(red: 126 / 255, green: 206 / 255, blue: 144 / 255))
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .padding(.bottom, 29)
                            VStack {
                                Text("Total Score: \(totalScore)")
                                Text("Questions remaining: \(remainingQuestions)")
                            }
                        }.padding(20)
                        .background(Color(red: 245/255,green:234/255,blue:234/255))
                        .navigationBarTitle("Edutainment")
                    }
                    else{
                        VStack {
                            Text("Select multiplication number")
                                .multilineTextAlignment(.center)
                            Picker("",selection: $multiplicationNum){
                                ForEach(0 ..< mults.count ) {
                                    Text(String(self.mults[$0]))
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color(red: 126 / 255, green: 206 / 255, blue: 144 / 255))
                            .cornerRadius(25)
                            .padding(.bottom, 10)
                            
                            Picker("How many question you want to be asked?", selection: $questionNum) {
                                ForEach(variantsOfQuestions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color(red: 126 / 255, green: 206 / 255, blue: 144 / 255))
                            .cornerRadius(25)
                            .padding(.bottom, 10)
                            
                            
                           
                            Spacer()
                            HStack {
                                ForEach (imgs, id: \.self) { im in
                                    Image(im).resizable()
                                        .frame(width: 60, height: 55)
                                }
                            }
                            
                            Button("Start game") {
                                self.newGame()
                            }
                            .padding(10)
                            .background(Color(red: 126 / 255, green: 206 / 255, blue: 144 / 255))
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .padding(.bottom, 70)
                        }
                        .padding(20)
                        .background(Color(red: 245/255,green:234/255,blue:234/255))
                        .navigationBarTitle("Edutainment")
                    }
                
                }
            }.alert(isPresented: $isShowAlert) {
                Alert(title: Text("\(alertTitle)"), message: Text("You score is: \(totalScore)"), dismissButton: .default(Text("\(buttonAlertTitle)")){
                    self.checkGame()
                    }
                )
            }
        
        
        }
        
    }
    func checkGame() {
        if self.isWinGame {
            self.newGame()
            self.isWinGame = false
            self.isCorrect = false
        }
        else if self.isCorrect  {
            self.isCorrect = false
            self.newQuestion()
        }
        else {
            self.isWrong = false
        }
    }
    func createArrayOfQuestions() {
        for i in 1...multiplicationNum {
            for j in 1...12 {
                let newQuestion = Question(text: "How much is \(i) * \(j) ?", answer: i * j)
                arrayOfQuestions.append(newQuestion)
            }
        }
        self.arrayOfQuestions.shuffle()
        self.currentQuestion = 0
        self.answerArray = []
    }
    func setCountOfQuestions() {
        guard let count = Int(self.questionNum) else {
            remainingQuestions  = arrayOfQuestions.count
            return
        }
        
        remainingQuestions = count
    }
    func createAnswersArray() {
        if currentQuestion + 4 < arrayOfQuestions.count {
            for i in currentQuestion ... currentQuestion + 3 {
                answerArray.append(arrayOfQuestions[i])
            }
        } else {
            for i in arrayOfQuestions.count - 4 ..< arrayOfQuestions.count {
                answerArray.append(arrayOfQuestions[i])
            }
        }
        self.answerArray.shuffle()
    }
    func newGame() {
        self.gameStarted = true
        self.arrayOfQuestions = []
        self.createArrayOfQuestions()
        self.currentQuestion = 0
        self.setCountOfQuestions()
        self.answerArray = []
        self.createAnswersArray()
        self.imgs.shuffle()
        self.totalScore = 0
        
    }
    func newQuestion() {
        self.imgs.shuffle()
        self.currentQuestion += 1
        self.answerArray = []
        self.createAnswersArray()
    }
    func checkAnswer(_ number: Int) {
        self.selectedNumber = number
        if answerArray[number].answer == arrayOfQuestions[currentQuestion].answer {
            self.isCorrect = true
            self.remainingQuestions -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if self.remainingQuestions == 0 {
                    self.alertTitle = "You win"
                    self.buttonAlertTitle = "Start new game"
                    self.totalScore += 1
                    self.isWinGame = true
                    self.isShowAlert = true
                } else {
                    self.totalScore += 1
                    self.alertTitle = "Correct"
                    self.buttonAlertTitle = "New Question"
                    self.isShowAlert = true
                }
            }
        } else {
            isWrong = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.alertTitle = "Wrong"
                self.buttonAlertTitle = "Try again"
                self.isShowAlert = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
