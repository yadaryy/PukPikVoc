//
//  VocabQuiz.swift
//  PukPikGame
//
//  Created by Chonlada Boonanan on 7/12/2564 BE.
//

import SwiftUI

struct VocabQuiz: View {
    @Binding var Vocab : vocab
    @Binding var correct : Int
    @State var selected = ""
    
    var body: some View {
        VStack(spacing: 30){
            Text(Vocab.eng)
                .font(.custom("ARCADECLASSIC", size: 40))
                .foregroundColor(.black)
                .padding(.top,60)
            //ตัวเลือกต่าง ๆ
            HStack(spacing: 10){
                Button(action: {
                    selected = Vocab.optionA
                    checkAns()
                    withAnimation{Vocab.completed.toggle()}
                }, label: {
                    Text(Vocab.optionA)
                        .font(.custom("lookpeach", size: 20))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(25)
                })
                    //disabling
                    .disabled(Vocab.isSubmitted ? true : false)
                    .opacity(Vocab.isSubmitted ? 0.7 : 1)
                
                Button(action: {
                    selected = Vocab.optionB
                    checkAns()
                    withAnimation{Vocab.completed.toggle()}
                }, label: {
                    Text(Vocab.optionB)
                        .font(.custom("lookpeach", size: 20))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(25)
                })
                    .disabled(Vocab.isSubmitted ? true : false)
                    .opacity(Vocab.isSubmitted ? 0.7 : 1)
            }
            .padding(.bottom)
           
        }
        .padding()
        .background(Color.white)
        .cornerRadius(40)
        .frame(width: 350, height: 200)
        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 1, x: -5, y: -5)
    }    
    //Check answer
    func checkAns() {
        if selected == Vocab.answer{
            correct += 1
        }
        Vocab.isSubmitted.toggle()
    }

}


