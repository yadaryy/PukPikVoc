//
//  GameView.swift
//  Finalproject2
//
//  Created by Yadar Tulayathamrong on 28/11/2564 BE.
//

import SwiftUI
import SpriteKit
import CoreMIDI
import grpc

struct GameView: View {
    @State var isGamepaused : Bool = false
    @State var Showpausebutton = true
    @State private var isMusicpaused : Bool = false
    @State var timeShowing : Int = 60
    @State private var exitgame : Bool = false
    @StateObject var data = PukPikviewmodel()
    
    let levelN = SKScene(fileNamed: "normalLevel")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //for show score
    @Binding var correct : Int
  
    var body: some View {
        NavigationView{
        ZStack{
            if data.list.isEmpty{
                ProgressView()
            }
            else{
                ZStack(alignment: .top ){
                    SpriteView(scene: levelN! , isPaused: isGamepaused).ignoresSafeArea()
        
                HStack{
                    VStack(){
                        StrokeText(text: "Point", width: 2, color: .black)
                            .font(.custom("Pixel Bug", size: 22))
                            .foregroundColor(.white)
                    
                        
                        Spacer().frame(height:20)
                        
                        ZStack{
                            Text(correct == 0 ? "0" : "\(correct)")
                                .font(.custom("Pixel Bug", size: 30))
                                .foregroundColor(.black)
                            
                        }.frame(width: 150, height: 50).background(.white).clipShape(RoundedRectangle(cornerRadius: 25))
                        
                        Spacer().frame(height:20)
                        
                        StrokeText(text: "Timer : \(timeShowing) ", width: 2, color: .black)
                            .font(.custom("Pixel Bug", size: 22))
                            .foregroundColor(.white)
                            .onReceive(timer) { _ in
                                if !isGamepaused{
                                    if timeShowing > 0 {
                                        timeShowing -= 1
                                        if isGamepaused {
                                        self.timer.upstream.connect().cancel()
                                        }
                                    }
                                }
                            }
                    
                        
                    }.frame(width:200)
                    Spacer().frame(width:22)
                    VStack{
                        Spacer().frame(height:50)
                        if Showpausebutton {
                            Button(action: {isGamepaused.toggle()
                                            Showpausebutton.toggle()
                            }, label: {
                            Image(uiImage : UIImage(named: "pauseButton")!)
                            })
                        }
                        Button(action: {isMusicpaused.toggle()
                            pausesound()
                            playBGsound(isMusicpause: isMusicpaused)
                        }, label: {
                            ZStack{
                                Image(uiImage : UIImage(named: "musicbutton")!)
                                    .resizable()
                                    .frame(width: 100, height: 70)

                            if isMusicpaused {
                                Text("*")
                                    .foregroundColor(.red)
                                    .font(.custom("ARCADECLASSIC", size: 60))
                            }
                            }
                        })
                    }
                }
                }
                if isGamepaused && !exitgame {
                    ZStack(){
                            Image(uiImage: UIImage(named: "popup")!)
                            .resizable()
                            .frame(width: 380, height: 240)
                            VStack{
                                Button(action: { isGamepaused.toggle()
                                                Showpausebutton.toggle()
                                }, label:{ Image(uiImage : UIImage(named: "resumeButton")!)
                                        .resizable()
                                        .frame(width: 200, height: 70)
                            })
                                
                                Button(action: { exitgame.toggle()}, label:{ Image(uiImage : UIImage(named: "exitButton")!)
                                        .resizable()
                                        .frame(width: 200, height: 65)
                            })
                        }
                    }
                    
                }
                
                if !isGamepaused {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content:{
                            ForEach(data.list.reversed().indices){index in
                                VocabQuiz(Vocab: $data.list[index], correct: $correct)
                                    //if quiz complete moving away
                                    .offset(x: data.list[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.list[index].completed ? 1000 : 0))
                            }
                        
                    })
                    
                }
                
                if exitgame || timeShowing==0{
                    ZStack{
                        Image(uiImage: UIImage(named: "popup")!)
                            .resizable()
                            .frame(width: 400, height: 260)
                        VStack{
                            Text("YOUR  SCORE")
                                .font(.custom("ARCADECLASSIC", size: 40))
                                .foregroundColor(.white)
                            Text("\(correct)")
                                .font(.custom("ARCADECLASSIC", size: 80))
                                .foregroundColor(.white)
                            Spacer().frame(height:5)
                            NavigationLink(destination: Home(), label: {Image(uiImage: UIImage(named: "homeButton")!)
                                .resizable()
                                .frame(width: 50, height: 50)})
                        }
                    }
                }

        }
        }.frame(width: 428, height: 926)
        .onAppear(perform: {
            data.fetchdata()
        })
    }       .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
    }
  
}










