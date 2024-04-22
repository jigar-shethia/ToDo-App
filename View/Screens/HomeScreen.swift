//
//  HomeScreen.swift
//  ToDo App
//
//  Created by Jigar Shethia on 13/04/24.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            TodoScreen()
                .tabItem {
                    Image(systemName: "note.text")
                  
                }
            StopwatchScreen()
                .tabItem {
                    Image(systemName: "stopwatch")
                    
                }
        }
    }
}

#Preview {
    HomeScreen()
}
