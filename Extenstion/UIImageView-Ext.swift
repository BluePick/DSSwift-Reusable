extension UIImageView {
    
    func setImageUsingSDWebImage(with url: String, placeholderImage: UIImage?)
    {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.white)
        self.sd_setImage(with: URL(string:url), placeholderImage: placeholderImage, options: .scaleDownLargeImages, completed: nil)
        //        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
    }
}
