//
//  ContentView.swift
//  PIG
//
//  Created by Betzy Moreno on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            VStack {
                Image("Pig").resizable().frame(width: 150, height: 150)
                Text("Pig")
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
