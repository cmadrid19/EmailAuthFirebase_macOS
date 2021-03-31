//
//  EmailAuthFirebaseApp.swift
//  EmailAuthFirebase
//
//  Created by Maxim Macari on 31/3/21.
//

import SwiftUI
import Firebase


@main
struct EmailAuthFirebaseApp: App {
    // Conecting
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //hidding window..
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

//App deelegate
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        //Init firebase
        FirebaseApp.configure()
    }
}

//To hide focus ring on textfield
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get {.none}
        set {}
    }
}
