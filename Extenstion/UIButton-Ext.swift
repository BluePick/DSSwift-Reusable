
extension UIButton {
    
    @IBInspectable var titleThemedColor: String {
        set{
            self.setTitleColor(Style.Color.named(newValue), for: .normal)
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var localizedBGImage: String {
        set{
            self.setBackgroundImage(Style.Image.getImage(with: newValue), for: .normal)
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var customFontType: String {
        set{
            if self.titleLabel != nil
            {
                if let sizeType = Style.Font.SizeType(rawValue: newValue)
                {
                    self.titleLabel?.font = UIFont(name: self.titleLabel!.font.fontName, size: sizeType.size)
                }
            }
        }
        get {
            let size = Int(Style.Font.SizeType.button.size)
            return String(size)
        }
    }
    
    func underlineTitle() {
        
        let text = self.accessibilityLabel!.localizedString()
        let titleString = NSMutableAttributedString(string: text)
        
        titleString.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSFontAttributeName: (self.titleLabel?.font)!, NSForegroundColorAttributeName: (self.titleLabel?.textColor)!], range: NSMakeRange(0, text.characters.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
}

