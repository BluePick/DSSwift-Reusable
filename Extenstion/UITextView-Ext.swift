extension UITextView {
    
    @IBInspectable var textThemedColor: String {
        set{
            self.textColor = Style.Color.named(newValue)
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var customFontType: String {
        set{
            if self.text != nil
            {
                if let sizeType = Style.Font.SizeType(rawValue: newValue)
                {
                    self.font = UIFont(name: self.font!.fontName, size: sizeType.size)
                }
            }
        }
        get {
            let size = Int(Style.Font.SizeType.content.size)
            return String(size)
        }
    }
}
