//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/1/22.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var vm = HomeViewModle()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
