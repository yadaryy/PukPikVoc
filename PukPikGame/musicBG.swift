//
//  musicBG.swift
//  Finalproject2
//
//  Created by Yadar Tulayathamrong on 30/11/2564 BE.
//

import AVFoundation

var audioplayer : AVAudioPlayer?
func playsound(sound:String , type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioplayer?.play()
        }catch {
            print("Error JA")
        }
    }
}
func pausesound() {
    audioplayer?.pause()
}

func playBGsound(isMusicpause:Bool){
    if isMusicpause == false {
    audioplayer?.play()
    }
}
