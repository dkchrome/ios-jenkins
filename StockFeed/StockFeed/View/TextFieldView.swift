//
//  TextFieldView.swift
//  StockFeed
//
//  Created by Deepak Kumar on 14/04/21.
//

import SwiftUI

struct TextFieldView: View {
    var title: String = ""
    var placeholder: String = ""
    @Binding var text: String
    var errorMsg: String = ""
    @State var textEntered = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5, content: {
            Text(title).padding(.leading, 10)

            TextField(placeholder, text: $text, onEditingChanged: { (change) in
                if text == "" {     //On first time tap on textfield will not trigger error.
                    //return
                }
                textEntered = true
            }, onCommit: {
                
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if textEntered && !errorMsg.isEmpty {
                Text(errorMsg).foregroundColor(.red)
            }
            
        }).padding([.leading, .trailing], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        
    }
}


struct SecureTextField: View {
    var title: String = ""
    var placeholder: String = ""
    @Binding var text: String
    var errorMsg: String = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5, content: {
            Text(title).padding(.leading, 10)

            SecureField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if text != "" {
                Text(errorMsg).foregroundColor(.red)
            }            
            
        }).padding([.leading, .trailing], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
