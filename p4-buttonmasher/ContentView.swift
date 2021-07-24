//
//  ContentView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to my first App")
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .padding()
            Button(action: {
                print("buton pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hete Me!")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert (title: Text("hello there!"), message: Text("this is my first popup"), dismissButton: .default(Text("Awesome!")))
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
