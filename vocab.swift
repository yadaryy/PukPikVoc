//
//  vocab.swift
//  PukPikGame
//
//  Created by Chonlada Boonanan on 4/12/2564 BE.
//

import Foundation

struct vocab:Identifiable {
    var id:String
    var eng:String
    var optionA:String
    var optionB:String
    var answer : String
    
    var isSubmitted = false
    var completed = false
    
}
