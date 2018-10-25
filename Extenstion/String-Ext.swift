extension String
{
    var isValisValidNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    
    var isNumeric: Bool
    {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
    
    
    func removeWhiteSpace() -> String {
        let strValue = self.trimmingCharacters(in: NSMutableCharacterSet.whitespaceAndNewline() as CharacterSet)
        return strValue
    }
    
    func isBlank() -> Bool {
        
        let strValue = self.removeWhiteSpace()
        
        if (strValue.characters.count <= 0) {
            return true
        }
        return false
    }
    
    func isEmail() -> Bool
    {
        do {
            
            let pattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
                "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
                "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
                "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
        
    }
    
    func isPhoneNumber() -> Bool {
        
        let phoneNumber = self.removeWhiteSpace()
        
        if Validator.isValueIsWithing(minimumValue: 7, and: 16, strVal: phoneNumber){
            //            let aCharcterSet = NSMutableCharacterSet.decimalDigit()
            ////            aCharcterSet.addCharacters(in: "'-*+#,;. ")
            //            let boolValidator = self.validateInCharacterSet(aCharcterSet, strVal: strValue)
            //            if boolValidator == false {
            //                return false
            //            }
            return true
        }else{
            return false
        }
    }
    
    func htmlAttributedString() -> NSMutableAttributedString? {
        
        let headerSize = Style.Font.SizeType.h2.size
        let bodySize = Style.Font.SizeType.content.size
        
        var style = ("<style>h1{font-family: '\(Style.Font.kCrossTown.localizedString())'; font-size: \(headerSize)px;}</style>")
        style.append("<style>*{font-family: '\(Style.Font.kAvenirNextRegular.localizedString())'; font-size: \(bodySize)px;}</style>")
        
        return htmlAttributedString(withStyle: style)
    }
    
    func htmlAttributedString(withStyle style: String) -> NSMutableAttributedString? {
        
        var text = self
        text.append(style)
        
        guard let data = text.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    //    func htmlAttributedString() -> NSAttributedString? {
    //
    //        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
    //        guard let html = try? NSMutableAttributedString(
    //            data: data,
    //            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
    //            documentAttributes: nil) else { return nil }
    //        return html
    //    }
    
    
}
