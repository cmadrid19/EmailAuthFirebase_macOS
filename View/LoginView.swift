//
//  Home.swift
//  EmailAuthFirebase
//
//  Created by Maxim Macari on 31/3/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginData = LoginViewModel()
    @State private var hover: Bool = false
    
    
    var body: some View {
        let width = getRect().width / 1.6
        
        HStack(spacing: 0){
            
            
            VStack(alignment: .leading, spacing: 18, content: {
                //Login view
                Text("Welcome to this site")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                
                //Login
                if !loginData.isNewUser {
                    CustomTeextField(value: $loginData.userName, hint: "User name")
                    
                    CustomTeextField(value: $loginData.password, hint: "password", secured: true)
                        
                    
                    //Forget password button
                    Button(action: {
                        loginData.resetPassword()
                    }, label: {
                        Text("Forget Password")
                            .font(.caption)
                            .foregroundColor(hover ? .white : .gray)
                            .fontWeight(.semibold)
                            .onHover(perform: { hovering in
                                hover.toggle()
                            })
                        
                    })
                    .disabled(loginData.userName == "")
                    .opacity(loginData.userName == "" ? 0.8 : 1)
                    
                    VStack(spacing: 10){
                        Button(action: {
                            loginData.loginUser()
                        }, label: {
                            Text("Login")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                            
                        })
                        .disabled(loginData.userName == "" || loginData.password == "")
                        .opacity(loginData.userName == "" || loginData.password == "" ? 0.6 : 1)
                        
                        Button(action: {
                            withAnimation {
                                loginData.isNewUser.toggle()
                            }
                        }, label: {
                            Text("Sign up")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            
                        })
                    }
                    .padding(.top)
                }
                else {
                    
                    //Back button
                    Button(action: {
                        withAnimation{
                            loginData.isNewUser.toggle()
                        }
                    }, label: {
                        Label(
                            title: { Text("Back")
                                .fontWeight(.semibold)
                            },
                            icon: { Image(systemName: "chevron.left")
                                .font(.caption)
                                .foregroundColor(.gray)
                            })
                    })
                    
                    CustomTeextField(value: $loginData.registerUserName, hint: "User name")
                    
                    CustomTeextField(value: $loginData.registerPassword, hint: "password", secured: true)
                    
                    CustomTeextField(value: $loginData.reEnterPassword, hint: " password", secured: true)
                    
                    VStack(spacing: 10){
                        Button(action: {
                            loginData.registerUser()
                        }, label: {
                            Text("Sing Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                            
                        })
                        .disabled(loginData.registerUserName == "" || loginData.registerPassword == "" || loginData.reEnterPassword == "")
                        .opacity(loginData.registerUserName == "" || loginData.registerPassword == "" || loginData.reEnterPassword == "" ? 0.6 : 1)
                    }
                    .padding(.top)
                }
                
                
            })
            .textFieldStyle(PlainTextFieldStyle())
            .buttonStyle(PlainButtonStyle())
            .padding()
            .padding(.horizontal)
            .offset(y: -50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .zIndex(1)
            
            Image("pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width / 1.6)
                .clipped()
            
        }
        .ignoresSafeArea()
        .overlay(
            ZStack{
                if loginData.isLoading {
                    LoadingScreen()
                }
            }
        )
        .frame(width: width, height: getRect().height - 180)
        .alert(isPresented: $loginData.showError, content: {
            Alert(title: Text("Message"), message: Text("\(loginData.errorMsg)"), dismissButton: .destructive(Text("Ok"), action: {
                //Close loading screen
                withAnimation{
                    loginData.isLoading = false
                }
            }))
        })
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Extending view to get screen rect
extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}



struct CustomTeextField: View {
    
    @Binding var value: String
    var hint: String = ""
    @State var secured: Bool?
    @State private var showPass = false
    
    var body: some View {
        VStack(alignment: .leading
               , spacing: 6, content: {
                Text("Enter \(hint)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ZStack{
                    if secured ?? false {
                        HStack(spacing: 0){
                            if showPass {
                                TextField(hint, text: $value)
                            } else {
                                SecureField(hint, text: $value)
                            }
                            Button(action: {
                                self.showPass.toggle()
                            }, label: {
                                Image(systemName: showPass  ? "eye" : "eye.slash")
                            })
                        }
                    } else {
                        TextField(hint, text: $value)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.13))
                .cornerRadius(8)
                .colorScheme(.dark)
                .keyboardShortcut(.tab)
                
               })
    }
}
