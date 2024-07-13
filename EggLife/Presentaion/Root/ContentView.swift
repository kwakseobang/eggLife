//
//  ContentView.swift
//  EggLife
//
//  Created by 곽서방 on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunching: Bool = true
    var body: some View {
        
        ZStack{
            if isLaunching {
                SplashView()
                    .opacity(isLaunching ? 1 : 0)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeIn(duration: 1)) {
                                isLaunching = false
                            }
                        }
                    }
            } else {
                MainView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
