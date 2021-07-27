//
//  ContentView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/24/21.
//

import SwiftUI

enum SquareStatus {
    case empty
    case home
    case visitor
}

class Square : ObservableObject {
    @Published var squareStatus : SquareStatus
    init(status : SquareStatus){
        self.squareStatus = status
    }
}

class TicTacToeModel: ObservableObject {
    @Published var squares = [Square]()
    init() {
        for _ in 0...8 {
            squares.append(Square(status: .empty))
        }
    }

}



struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 3
    @State var invis = true
    @State var gameOne = true
    @State var gameTwo = false
    @StateObject var ticTacToeModel = TicTacToeModel()
    
    struct LableStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("HelveticaNeue-Medium", size: 18))
        }
    }
    
    var body: some View {
    
        VStack {
            // ~~~~~~~~~~~~~~~~ inside for game two
            
                
                Text("TicTacToe?")
                ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                    row in
                    HStack {
                        ForEach(0 ..< 3, content:{
                            column in
                            Color.gray.frame(width: 70, height: 70, alignment: .center)
                        })
                    }
                })
            
            
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                if round != 0{
//                    Spacer()
//                    // Target row
//                    HStack {
//                        Text("Put the bullseye as close as you can to:").modifier(LableStyle())
//
//                        Text("\(target)")
//
//                    }
//                    Spacer()
//                    // the gap between bullseye and slider
//                    if invis == false {
//                        Text("this is the slider value \(sliderValue)")
//                    }
//                    Spacer()
//                    // Slider Row
//                    HStack{
//                        Text("1").modifier(LableStyle())
//
//                        Slider(value: $sliderValue, in: 1...100)
//                        Text("100").modifier(LableStyle())
//
//                    }
//                    Spacer()
//                    // button row
//                    Button(action: {
//                        print("buton pressed!, \(score)" )
//                        self.alertIsVisible = true
//
//                    }) {
//                        Text("Hit Me!").modifier(LableStyle())
//
//                    }
//                    .alert(isPresented: $alertIsVisible) { () -> Alert in
//
//                        return Alert (title: Text(alertTitle()), message: Text(
//                            "The slider's value is \(sliderValueRounded()).\n" +
//                            "You scored \(pointsForCurrentRound()) points this round."
//                        ), dismissButton: .default(Text("Awesome!")) {
//                            self.score = self.score + self.pointsForCurrentRound()
//                            self.target = Int.random(in: 1...100)
//                            self.round -= 1
//                            self.sliderValue = 50.00
//    //                        if round == 0 {
//    //                            startNewGame()
//    //                            startNextGame()
//    //                        }
//
//                        })
//                    }
//                    Spacer()
//
//                }
//    //            else if gameTwo == true && round == 1 {
//    //
//    //            }
//                if round == 0 {
//                    Text("Finished!").font(Font.custom("HelveticaNeue-Medium", size: 58))
//                }

            // Score row work above here ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            HStack {


                Button(action: {

                    startNewGame()
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
                Button(action:{ }) { // create the view, push the view controller somehow.
                    Text("Info")
                }


            }
            .padding(.bottom, 30)
           
        }
//        .background(Image("grasstexture3"), alignment: .center)
        .padding(.horizontal, 20)
  
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
    func startNewGame() {
        score = 0
        round = 3
        sliderValue = 50.0
        target = Int.random(in: 1...100)
        }
       

    func startNextGame() {
        gameOne = false
        
        gameTwo = true
    
    }
}
struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 414, height: 896))
    }
}
