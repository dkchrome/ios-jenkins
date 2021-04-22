//
//  Validator.swift
//  StockFeed
//
//  Created by Deepak Kumar on 13/04/21.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class Validator: NSObject {
	
	static func isValidEmail (_ textfield: UITextField) -> Bool{
		guard let email = textfield.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {return false}
		textfield.text = email
        
        return Validator.isValidEmail(email)
	}
    
    static func isValidEmail (_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z.]{2,10}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
	
	static func isAlphaNumericPassword (_ password: String) -> Bool{
		let passwordRegex = "^(?!.*(.)\\1{3})((?=.*[\\d])(?=.*[A-Za-z])|(?=.*[^\\w\\d\\s])(?=.*[A-Za-z])).{6,20}$"
		let passwordTest = NSPredicate.init(format: "SELF MATCHES %@", passwordRegex)
		return passwordTest.evaluate(with: password)
	}
	
	static func isValidPassword (_ password: String?) -> Bool{
		guard let password = password?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {return false}
		return password.count >= 6 ? true : false
	}
	
}
