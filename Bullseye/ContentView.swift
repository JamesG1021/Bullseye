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
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
            .foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arield Rounded MT Bold", size: 24))
                .modifier(Shadow())
        }
    }
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arield Rounded MT Bold", size: 18))
                .modifier(Shadow())
        }
    }
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arield Rounded MT Bold", size: 12))
                .modifier(Shadow())
        }
    }

    
    var body: some View {
        
        VStack {
            Spacer()
            //Target Row
            HStack {
                Text("Put the Bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            // slider row
            HStack{
                Text("1").modifier(LabelStyle())
                
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
            // button row
            Spacer()
            Button(action: {
                self.alertIsVisible = true
                self.calculateScore()
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text("\(self.alertTitle())"), message: Text("The slider's value is \(sliderValueRounded()).\n" + "you scored \(pointsForCurrentRound()) points this round!"), dismissButton: .default(Text("awesome")){
                    self.newTarget()
                    self.round += 1
                })
            }
            .background(Image("Button")).modifier(Shadow())
            
            Spacer()
            //score row
            HStack {
                Button(action: {
                    self.restartGame()
                }) {
                    HStack{
                        Image("StartOverIcon")
                    Text("Start over").modifier(ButtonSmallTextStyle())
                }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                    Text("Info").modifier(ButtonSmallTextStyle())
                        Image("InfoIcon")
                }
                }
                 .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
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

