//
//  LHPPWalletApp.swift
//  LHPPWallet
//
//  Created by sopheakneath on 4/3/26.
//

import SwiftUI
import CoreData


@main
struct LHPPWalletApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            WelcomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
    
        }
        .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("App is active and interactive.")
                    case .inactive:
                        print("App is running but inactive (e.g., overlay present).")
                    case .background:
                        print("App went to background. Time to save data!")
                    @unknown default:
                        print("A new unexpected phase occurred.")
                    }
                }
    }
}
