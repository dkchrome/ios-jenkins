//
//  ContentView.swift
//  StockFeed
//
//  Created by Deepak Kumar on 12/04/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        if DataManager.shared.getUser() != nil {
            NavigationView {
                HomeView()
            }
        } else {
            SignupView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct SignupView: View {
    @StateObject var signupViewModel = SignupViewModel()
    
    @State private var showAlert = false
    @State private var moveNext = false
    
    var signInButton: some View {
        NavigationLink(destination: HomeView(), isActive: .constant(moveNext)) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(signupTxt).foregroundColor(.white).fontWeight(.bold)
                        Spacer()
                    }
                    Spacer()
                }.frame(minHeight: 55.0, maxHeight: 55.0)
                .background(signupViewModel.isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(5)
                .padding([.top, .leading, .trailing], 25)
                
            }.simultaneousGesture(TapGesture().onEnded{
                UIApplication.shared.endEditing()
                self.signup()
            }).disabled(!signupViewModel.isFormValid)
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 20.0, content: {
                TextFieldView(title: nameTxt, placeholder: enterNameTxt, text: $signupViewModel.name, errorMsg: signupViewModel.usernameMessage)
                
                TextFieldView(title: emailTxt, placeholder: enterEmailTxt, text: $signupViewModel.email, errorMsg: signupViewModel.emailMessage)
                
                SecureTextField(title: passwordTxt, placeholder: enterPasswordTxt, text: $signupViewModel.password, errorMsg: signupViewModel.passwordMessage)
                
                signInButton
                
                Spacer()
            })
        }
    }
    
    private func signup() {
        if signupViewModel.isFormValid {
            signupViewModel.signup()
            moveNext = true
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
