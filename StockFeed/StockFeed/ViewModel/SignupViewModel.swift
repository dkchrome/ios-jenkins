//
//  SignupViewModel.swift
//  StockFeed
//
//  Created by Deepak Kumar on 12/04/21.
//

import Foundation
import UIKit
import Combine

class SignupViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var usernameMessage = ""
    @Published var emailMessage = ""
    @Published var passwordMessage = ""
    
    @Published var isFormValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $name.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 1
            }.eraseToAnyPublisher()
    }
    
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
        Publishers.CombineLatest3(isNameValidPublisher, isEmailValidPublisher, isPasswordValidPublisher)
          .map { userNameIsValid, emailIsValid, passwordValid in
            return userNameIsValid && emailIsValid && passwordValid
          }
        .eraseToAnyPublisher()
      }
    
    
    init() {
        isNameValidPublisher
          .receive(on: RunLoop.main)
          .map { valid in
            valid ? "" : nameEmptyMsg
          }
          .assign(to: \.usernameMessage, on: self)
          .store(in: &cancellableSet)
        
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
    
    
    func signup() {
        if isFormValid {
            let user = User(name: name, email: email, password: password)
            DataManager.shared.saveUser(user: user)
        }
    }
}
