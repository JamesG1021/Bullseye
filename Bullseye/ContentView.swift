//
//  ContentView.swift
//  Bullseye
//
//  Created by James Gray on 3/16/20.
//  Copyright © 2020 Gray, James S. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1

    
    var body: some View {
        VStack {
            Spacer()
            //Target Row
            HStack {
                Text("Put the Bullseye as close as you can to:")
                Text("\(target)")
            }
            Spacer()
            // slider row
            HStack{
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            
            // button row
            Spacer()
            Button(action: {
                self.alertIsVisible = true
                self.calculateScore()
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text("\(self.alertTitle())"), message: Text("The slider's value is \(sliderValueRounded()).\n" + "you scored \(pointsForCurrentRound()) points this round!"), dismissButton: .default(Text("awesome")){
                    self.newTarget()
                    self.round += 1
                })
            }
            
            Spacer()
            //score row
            HStack {
                Button(action: {
                    self.restartGame()
                }) {
                    Text("Start over")
                }
                Spacer()
                Text("Score")
                Text("\(score)")
                Spacer()
                Text("Round")
                Text("\(round)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    func sliderValueRounded() -> Int{
       Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int{
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0{
            bonus = 100
        }else if difference == 1 {
            bonus = 50
        }else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    func calculateScore(){
        self.score += pointsForCurrentRound()
    }
    
    func newTarget() {
        target = Int.random(in: 1...100)
    }
    
    func restartGame(){
        sliderValue = 50.0
        newTarget()
        score = 0
        round = 1
    }
    func alertTitle() -> String{
        let difference = amountOff()
        let message: String
        if difference == 0 {
            message = "BULLSEYE!!"
        }else if difference < 5 {
            message = "So Close!"
        }else if difference < 10{
            message = "not bad"
        }else {
            message = "Too bad, Maybe next Time"
        }
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414
            ))
    }
}
