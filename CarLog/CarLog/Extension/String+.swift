import Foundation

extension String {
    // 대소문자, 특수문자, 숫자 8자 이상일 때 -> true
        func isValidPassword() -> Bool {
            let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
            let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
            
            return passwordValidation.evaluate(with: self)
        }
        
        // @와2글자 이상 확인 1@naver.com
        func isValidEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            return emailTest.evaluate(with: self)
        }
}