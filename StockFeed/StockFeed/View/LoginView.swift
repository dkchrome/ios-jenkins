//
//  LoginView.swift
//  StockFeed
//
//  Created by Deepak Kumar on 24/04/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var showAlert = false
    
    var signInButton: some View {
        NavigationLink(destination: HomeView(), isActive: .constant(loginViewModel.isLogIn)) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(loginTxt).foregroundColor(.white).fontWeight(.bold)
                        Spacer()
                    }
                    Spacer()
                }.frame(minHeight: 55.0, maxHeight: 55.0)
                .background(loginViewModel.isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(5)
                .padding([.top, .leading, .trailing], 25)
                
            }.simultaneousGesture(TapGesture().onEnded{
                UIApplication.shared.endEditing()
                self.signin()
            }).disabled(!loginViewModel.isFormValid)
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 20.0, content: {
                TextFieldView(title: emailTxt, placeholder: enterEmailTxt, text: $loginViewModel.email, errorMsg: loginViewModel.emailMessage)
                
                SecureTextField(title: passwordTxt, placeholder: enterPasswordTxt, text: $loginViewModel.password, errorMsg: loginViewModel.passwordMessage)
                
                signInButton
                
                NavigationLink(destination: SignupView()) {
                    Text(signupTxt)
                }
                
                Spacer()
            }).alert(isPresented: $showAlert, content: {
                
                Alert(title: Text(errorTitle), message: Text(userNotFoundMsg), dismissButton: .default(Text(okTxt)))
            })
        }.navigationBarTitle(Text(loginTxt))
        .navigationBarHidden(true)
    }
    
    private func signin() {
        if loginViewModel.isFormValid {
            loginViewModel.signin()
            showAlert = !loginViewModel.isLogIn
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


