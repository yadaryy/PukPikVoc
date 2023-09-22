//
//  Home.swift
//  PukPikGame
//
//  Created by Chonlada Boonanan on 6/12/2564 BE.
//

import SwiftUI
import AVFAudio
import SpriteKit

struct Home: View {
    let levelN = SKScene(fileNamed: "menuscene")
    @State private var isGamepaused : Bool = false
    @State var show = false
    @State var correct = 0
   

    var body: some View {
        NavigationView {
            ZStack(alignment: .top ){
                SpriteView(scene: levelN! , isPaused: isGamepaused).ignoresSafeArea()
        VStack{
            Spacer().frame(height:50)
            StrokeText(text: "PUKPIK", width: 5, color: .black)
                .font(.custom("Pixel Bug", size: 100)).foregroundColor(.white)
            StrokeText(text: "VOC", width: 5, color: .black)
                .font(.custom("Pixel Bug", size: 90)).foregroundColor(.pink)
            Spacer().frame(height:50)
            
            HStack{
                NavigationLink(destination: GameView(correct: $correct), label: {
                    Image(uiImage : UIImage(named: "playButton")!)
                    .resizable()
                    .frame(width:200 ,height:80)})

            }
            Spacer().frame(height:150)

        }.frame(width: 428 , height: 926 ,alignment: .top)
            }.frame(width: 400 , height: 830 )
                .navigationBarHidden(true)
                .onAppear(perform: {playsound(sound: "magic cliffs", type: "mp3")})
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}


