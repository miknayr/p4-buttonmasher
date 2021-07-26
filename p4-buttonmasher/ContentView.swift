//
//  ContentView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/24/21.
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
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
                
            }
            Spacer()
            // Slider Row
            HStack{
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            // button row
            Button(action: {
                print("buton pressed!, \(score)" )
                self.alertIsVisible = true
        
            }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
//                let roundedValue = Int(sliderValue.rounded())
                return Alert (title: Text(alertTitle()), message: Text(
                    "The slider's value is \(sliderValueRounded()).\n" +
                    "You scored \(pointsForCurrentRound()) points this round."
                ), dismissButton: .default(Text("Awesome!")) {
                    self.score = self.score + self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round += 1
                })
            }
            Spacer()
            // Score row
            HStack {
                Button(action: {
                    score = 0
                    target = Int.random(in: 1...100)
                    round = 1
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action:{}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 10)
        }
    }

    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "almost!"
        } else if difference <= 10 {
            title = "not bad"
        } else {
            title = "Not even close"
        }
        return title
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
