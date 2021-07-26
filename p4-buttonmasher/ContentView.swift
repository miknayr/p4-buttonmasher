//
//  ContentView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
                
            }
            Spacer()
            // Slider Row
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            // button row
            Button(action: {
                print("buton pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                var roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert (title: Text("hello there!"), message: Text(
                    "The slider's value is \(roundedValue).\n" +
                    "You scored \(self.pointsForCurrentRound()) points this round."
                ), dismissButton: .default(Text("Awesome!")))
            }
            Spacer()
            // Score row
            HStack {
                Button(action: {}) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                Spacer()
                Text("Round:")
                Text("999")
                Spacer()
                Button(action:{}) {
                    Text("Info")
                }
            }
            
            
            .padding(.bottom, 10)
        }
    }
    func pointsForCurrentRound() -> Int {
        var roundedValue: Int = Int(self.sliderValue.rounded())
        var difference: Int = self.target - roundedValue
        if difference < 0 {
            difference *= -1
        }

        var awardedPoints: Int = 100 - difference
        return awardedPoints
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
