//
//  Home.swift
//  EmailAuthFirebase
//
//  Created by Maxim Macari on 31/3/21.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        VStack(spacing: 20){
            Text("You are in!")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            Button(action: {
                // Log out
                try? Auth.auth().signOut()
                withAnimation{
                    status = false
                }
            }, label: {
                Text("Log out")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(8)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: getRect().width / 1.6, height: getRect().height - 180)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
