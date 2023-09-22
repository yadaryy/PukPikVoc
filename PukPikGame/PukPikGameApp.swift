//
//  PukPikGameApp.swift
//  PukPikGame
//
//  Created by Chonlada Boonanan on 2/12/2564 BE.
//

import SwiftUI
import Firebase

@main
struct PukPikGameApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBar(hidden: true)
        }
    }
}
