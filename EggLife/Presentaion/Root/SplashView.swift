//
//  SplashView.swift
//  EggLife
//
//  Created by 곽서방 on 7/8/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
    
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]),
                            startPoint: .top, endPoint: .bottom)
            
            VStack {
                Image("달걀")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,height: 300)
                Text("Egg_is_Life")
                    .font(.system(size: 40,weight:.bold))
                    .foregroundColor(.yellow)
            }
           }
            .edgesIgnoringSafeArea(.all)
      
       
    
    }
    
}

#Preview {
    SplashView()
}
