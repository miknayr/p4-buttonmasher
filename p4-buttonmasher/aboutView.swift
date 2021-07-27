//
//  aboutView.swift
//  p4-buttonmasher
//
//  Created by Ryan Kim on 7/26/21.
//

import SwiftUI

struct aboutView: View {
    var body: some View {
        VStack{
            Text("Button Masher")
            Text("made by Ryan K")
            
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct aboutView_Previews: PreviewProvider {
    static var previews: some View {
        aboutView().previewLayout(.fixed(width: 414, height: 896))
    }
}
