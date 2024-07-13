//
//  HardEggView.swift
//  EggLife
//
//  Created by 곽서방 on 7/8/24.
//

import SwiftUI

struct EggView: View {
    @StateObject var timerViewModel:TimerViewModel = TimerViewModel()
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]),
                               startPoint: .top, endPoint: .bottom)
                VStack(spacing: 30){
                    Spacer()
                        .frame(height: 70)
                    Image("반숙")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80,height: 80)
                    
                    TimerOperationView(timerViewModel: timerViewModel)
                    eggBtnView(timerViewModel: timerViewModel)
                    Spacer()
                    
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO:
//                        goToSetTimer = true
                    }label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 20))
                    }
                    .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $timerViewModel.goToSetTimer) {
                //modal로 표시되는 view를 navigationview로 감싸서 navigation bar 사용
                NavigationView{
                    TimePickerView(timerViewModel: timerViewModel)
                        .navigationBarBackButtonHidden()
                }
            }
            
        }
        
    }
}
//MARK: - Picker View
private struct TimePickerView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]),
                           startPoint: .bottom, endPoint: .top)
         
            VStack {
                Text( timerViewModel.eggType == .soft ? "반숙" : "완숙")
                    .font(.system(size: 30,weight: .semibold))
                
                Rectangle()
                  .fill(Color.yellow)
                  .frame(height: 1)
                
                HStack {
                    Picker("minutes", selection:  timerViewModel.eggType  == .soft ?
                           $timerViewModel.softEggTime.minutes:
                            $timerViewModel.hardEggTime.minutes
                    ) {
                        ForEach(0..<60) { m in
                            Text("\(m)분")
                        }
                    }
                    
                    Picker("seconds", selection:  timerViewModel.eggType  == .soft ?
                           $timerViewModel.softEggTime.seconds :
                            $timerViewModel.hardEggTime.seconds
                    ) {
                        ForEach(0..<60) { s in
                            Text("\(s)초")
                        }
                    }
                }
                .frame(height: 200)
                .labelsHidden()
                .pickerStyle(.wheel)
                Rectangle()
                  .fill(Color.yellow)
                  .frame(height: 1)
                PickerBtnView(timerViewModel: timerViewModel)
            }
         
        }
    }
}
// Picker Btn View
private struct PickerBtnView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    var body: some View {
        Button{
            //TODO: - SetTimerBtnTapped
            timerViewModel.timerSettingBtnTapped()
        }label: {
            Text("설정하기")
                .font(.system(size: 20,weight: .regular))
                .foregroundColor(.yellow)
            
        }
        .padding()
    }
}
// MARK: - 타이머 작동 뷰
private struct TimerOperationView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 38))
                        .foregroundColor(.black)
                        .monospaced()
                    
                    HStack(alignment: .center) {
                        Image(systemName: "bell.fill")
                        
                        Text( timerViewModel.eggType == .soft ?
                              "\(timerViewModel.softEggTime.convertedSeconds.formattedTimeString)" :"\(timerViewModel.hardEggTime.convertedSeconds.formattedTimeString)")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                        
                    }
                    .padding(.top,-10)
                }
                
                Circle()
                    .stroke(Color.orange, lineWidth: 6)
                    .frame(width: 350)
            }
            
            Spacer()
                .frame(height: 10)
            
        }
        .onAppear {
            timerViewModel.timeRemaining = timerViewModel.softEggTime.convertedSeconds
        }
    }
}

//MARK: - eggBtnView
private struct eggBtnView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    fileprivate var body: some View {
        HStack(spacing: 50) {
            VStack(spacing: 5){
                Button{
                    if timerViewModel.eggType == .hard {
                        timerViewModel.eggType  = .soft
                        timerViewModel.initBtnTapped()
                    } else {
                        timerViewModel.startOrPauseBtnTapped()
                    }
                    print(timerViewModel.eggType)
                } label: {
                    Image("반숙")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                }
                
                Text("Soft")
                    .font(.system(size: 18,weight: .medium))
                    .foregroundColor(.black)
                Button {
                    timerViewModel.eggType = .soft
                    timerViewModel.goToSetTimer = true
                }label: {
                    Image(systemName: "stopwatch")
                        .foregroundColor(.black)
                }
            }
            VStack(spacing: 5) {
                Button{
                    if timerViewModel.eggType == .soft {
                        timerViewModel.eggType  = .hard
                        timerViewModel.initBtnTapped()
                    } else {
                        timerViewModel.startOrPauseBtnTapped()
                    }
                    print(timerViewModel.eggType)
                } label: {
                    Image("반숙")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                }
                Text("Hard")
                    .font(.system(size: 18,weight: .medium))
                    .foregroundColor(.black)
                
                Button {
                    timerViewModel.eggType = .hard
                    timerViewModel.goToSetTimer = true
                  
                }label: {
                    Image(systemName: "stopwatch")
                        .foregroundColor(.black)
                }
            }
        }
        .highPriorityGesture(
            TapGesture(count: 2)
                .onEnded { _ in
                    timerViewModel.initBtnTapped()
                }
        )

    }
}
#Preview {
    EggView()
}
