//
//  ContentView.swift
//  EmailAuthFirebase
//
//  Created by Maxim Macari on 31/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        if status {
            Home()
        } else {
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
