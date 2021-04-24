//
//  LoginViewModel.swift
//  StockFeed
//
//  Created by Deepak Kumar on 24/04/21.
//

import Foundation
import UIKit
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var emailMessage = ""
    @Published var passwordMessage = ""
    
    @Published var isFormValid = false
    @Published var isLogIn = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Validator.isValidEmail(input)
            }.eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Validator.isAlphaNumericPassword(input)
            }.eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailValidPublisher, isPasswordValidPublisher)
          .map { emailIsValid, passwordValid in
            return emailIsValid && passwordValid
          }
        .eraseToAnyPublisher()
      }
    
    
    init() {
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : emailInvalidMsg
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : passwordInvalidMsg
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellableSet)
    }
    
    
    func signin() {
        if isFormValid {
            let user = User(name: "", email: email, password: password)
            
            let savedUser = DataManager.shared.getUser()
            if user.email == savedUser?.email && user.password == savedUser?.password {
                DataManager.shared.saveUserLoggedIn()
                isLogIn = true
            }
        }
    }
}
