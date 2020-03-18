//
//  AboutView.swift
//  Bullseye
//
//  Created by James Gray on 3/18/20.
//  Copyright © 2020 Gray, James S. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
   
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.bottom, 20)
                .padding(.top, 20)
        }
    }
    
    struct TextViewStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.bottom, 20)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .multilineTextAlignment(.center)
        }
    }
    
    
    var body: some View {
        Group {
            VStack{
                Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider").modifier(TextViewStyle())
                Text("Your goal is to place ths lider as close as possible to the target value. the closer you are, the more points you score!").modifier(TextViewStyle())
                Text("Enjoy!").modifier(TextViewStyle())
                
            }
            .background(beige)
            .navigationBarTitle("About Bullseye")
        }.background(Image("Background"), alignment: .center)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414
            ))
    }
}

