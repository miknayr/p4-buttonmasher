//
//  ContentView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 5.0
    @State var target = Int.random(in: 1...10)
    @State var score = 0
    @State var round = 2
    @State var invis = true
    @State var moves : [String] = Array(repeating: "", count: 9)
    // to identify the current player..
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    @State var timeRemaining = 10
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

 
    
    
    struct LableStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("HelveticaNeue-Medium", size: 18))
        }
    }
    struct CountdownStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("HelveticaNeue-Medium", size: 40))
        }
    }
    
    var body: some View {
        
        VStack {
            
        
                // ~~~~~~~~~~~~~~~~ inside for game two
                if round == 1 {
                    
                    VStack {
                        HStack{
                            VStack {

                                Text("The countdown:").modifier(CountdownStyle())
                                Text("\(timeRemaining)")
                                   .onReceive(timer) { _ in
                                       if timeRemaining > 0 {
                                            timeRemaining -= 1
                                    }
                                       else if timeRemaining == 0 && round == 1 {
                                            round -= 1
                                       }

                                }
                            }
                        }
                                              
                        // gridview for playing
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15){
                    ForEach(0..<9, id: \.self){index in
                    ZStack {
                                //Flip animation..
                                Color.blue
                                Color.gray
                                    .opacity(moves[index] == "" ? 1: 0)
                                Text(moves[index])
                                    .font(.system(size:55))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                    }
                                .frame(width: getWidth(), height: getWidth())
                                .cornerRadius(15)
                                // whenever tapped adding move
                                .onTapGesture(perform: {
                                
                                    if moves[index] == ""{
                                        moves[index] = isPlaying ? "X" : "O"
                                        // updating player
                                        isPlaying.toggle()
                                    }
                                })
                                
                            }
                        }
                        .padding(15)
                    }
                    // whenver moves updated, it will check for winner
                    .onChange(of: moves, perform: { value in
                        checkWinner()
                    })
                    .alert(isPresented: $gameOver, content: {
                        Alert(title: Text("Winner"), message: Text("You scored \(pointsForCurrentRoundTTT()) points this round."), dismissButton:
                                .destructive(Text("Play Again"), action:{
                                    // resetting all data
                                
                                    moves.removeAll()
                                    moves = Array(repeating:"", count: 9)
                                    
                                    self.timeRemaining = 10
                                    self.score = self.score + self.pointsForCurrentRoundTTT()
                                    self.round -= 1
                                    
                                }))
                    })
//                    .alert(isPresented: $alertIsVisible) { () -> Alert in
//
//                        return Alert (title: Text(alertTitle()), message: Text(
//                            msg + "You scored \(pointsForCurrentRoundTTT()) points this round."
//                        ), dismissButton: .default(Text("Awesome!")) {
//                            self.score = self.score + self.pointsForCurrentRoundTTT()
//
//
//
//
//                        })
//                    }
                    
                }
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if round == 2 {

                    Spacer()

                    // Target row
                    VStack{
                        Text("The countdown:").modifier(CountdownStyle())
                        Text("\(timeRemaining)")
                           .onReceive(timer) { _ in
                               if timeRemaining > 0 {
                                    timeRemaining -= 1
                            }
                               else if timeRemaining == 0 {
                                    round -= 1
                                    timeRemaining = 10
                                    
                               }
                          
                        }
                    }
                    Spacer()
                    
                    HStack {
                        Text("Put the bullseye as close as you can to:").modifier(LableStyle())
                        Text("\(target)")
                    }
                    Spacer()
                    // the gap between bullseye and slider

                    // Slider Row
                    HStack{
                        Text("1").modifier(LableStyle())

                        Slider(value: $sliderValue, in: 1...10)
                        Text("10").modifier(LableStyle())

                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    // button row
                    Button(action: {
                        print("buton pressed!, \(score)" )
                        self.alertIsVisible = true
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...10)
                        self.round -= 1
                        self.sliderValue = 5.00
                       
                        
                    }) {
                        Text("       ").modifier(LableStyle())
                            .background(Image("button").scaleEffect(0.3))
                           
                    }
                    
                    
                   
//                    .alert(isPresented: $alertIsVisible) { () -> Alert in
//
//                        return Alert (title: Text(alertTitle()), message: Text(
//                            "The slider's value is \(sliderValueRounded()).\n" +
//                            "You scored \(pointsForCurrentRound()) points this round."
//                        ), dismissButton: .default(Text("Awesome!")) {
//                            self.score = self.score + self.pointsForCurrentRound()
//                            self.target = Int.random(in: 1...10)
//                            self.round -= 1
//                            self.sliderValue = 5.00
//                            timeRemaining = 10
//
//
//                        })
//                    }
                    Spacer()


                }
   
                if round == 0 {
                    
                    Spacer()
                    VStack{
                        Text("Finished!").font(Font.custom("HelveticaNeue-Medium", size: 58))
                        Text("Start a new game!").font(Font.custom("HelveticaNeue-Medium", size: 15))
                        Text("")
                        Text("")
                    }
                   
                    VStack{
                        Text("Your Score is \(score)").font(Font.custom("HelveticaNeue", size: 20))
                    }
                    Spacer()
                }
            
                if round > 4 {
                    Spacer()
                    Text("Button Masher").font(Font.custom("HelveticaNeue-Medium", size: 40))
                    Text("Made by Ryan K!").font(Font.custom("HelveticaNeue-Medium", size: 15))
                    Spacer()
                    
                }
           

            // Score row work above here ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            HStack {

        
                Button(action: {

                    startNewGame()
                    timeRemaining = 10
                    moves.removeAll()
                    moves = Array(repeating:"", count: 9)
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
                Button(action:{
                    round = 10
                }) { // create the view, push the view controller somehow.
                    Text(" ")
                        .background(Image("info").scaleEffect(0.4))
                }


            }
            .padding(.bottom, 30)
            .padding(.horizontal, 40)
           
        }
//        .background(Image("grasstexture3"), alignment: .center)
  
    }

    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }


    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func amountOffTTT() -> Int {
        abs(10 - timeRemaining)
    }
    func pointsForCurrentRound() -> Int {
        let maximumScore = 10
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 20
        } else if difference == 1 {
            bonus = 6
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func pointsForCurrentRoundTTT() -> Int {
        let maximumScore = 10
        let difference = amountOff()
        let bonus: Int
        if difference == 1 {
            bonus = 30
        } else if difference == 2 {
            bonus = 20
        } else if difference == 3 {
            bonus = 10
        } else if difference == 4 {
            bonus = 7
        } else if difference == 5 {
            bonus = 5
        } else if difference == 6 {
            bonus = 3
        } else if difference == 7 {
            bonus = 2
        }  else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 1 {
            title = "almost!"
        } else if difference <= 2 {
            title = "not bad"
        } else {
            title = "Not even close"
        }
        return title
    }
    func startNewGame() {
        score = 0
        round = 2
        sliderValue = 5.0
        target = Int.random(in: 1...10)
        }
       
    func getWidth()->CGFloat{
        // horizontal padding = 30
        // spacing = 30
        let width = UIScreen.main.bounds.width - (30 + 30)
        return width / 3
    }
    
    // checking for winner 5:39min
    func checkWinner() {
        if checkMoves(player: "X") {
            // promoting alert view..
            msg = "Player X won"
            gameOver.toggle()
            
        }
       else if checkMoves(player: "O"){
            msg = "Player O won"
            gameOver.toggle()
        }
       else {
            // checking no moves
            let status = moves.contains { (value) -> Bool in
                return value == ""
            }
            if !status {
                msg = "Game Over"
                gameOver.toggle()
            }
       }
    }
    func checkMoves(player: String)-> Bool{
        // horizontal moves..
        for i in stride(from: 0, to: 9, by: 3){
            
            
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player {
                
                return true
            }
        }
        // vertical moves..
        for i in 0...2{
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player {
                
                return true
            }
        }
        // checking diagonals
        if moves[0] == player && moves[4] == player && moves[8] == player {
            
            return true
        }
        if moves[2] == player && moves[4] == player && moves[6] == player {
            
            return true
        }
        return false
    }
 

}
struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 414, height: 896))
    }
}
