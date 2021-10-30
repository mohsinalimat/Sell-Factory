//
//  Extensions.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

//MARK: - UIView Extensions
extension UIViewController {
    
    /// This function is used to setup shadow to a textfield
    /// - Parameter textField: Takes a UITextField as a paramter
    func setupShadowToTextField(textField: UITextField) {
        textField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 10.0
        textField.layer.masksToBounds = false
    }
    
    func setupShadowToUIView(uiview: UIView) {
        uiview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        uiview.layer.shadowOffset = CGSize(width: 0, height: 3)
        uiview.layer.shadowOpacity = 1.0
        uiview.layer.shadowRadius = 10.0
        uiview.layer.masksToBounds = false
    }
    
    
    ///This func sets up shadow to a uibutton
    func setupShadowToButton(button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }
    
    ///This func sets up shadow to a uibutton
    func setupShadowToImage(image: UIImageView) {
        image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 3)
        image.layer.shadowOpacity = 1.0
        image.layer.shadowRadius = 10.0
        image.layer.masksToBounds = false
    }
    
    
    
    func setupVC(bgColor: UIColor) {
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    
    ///This function configures the gradient background to any view controller
    func configureGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.frame
    }
    
    ///This function generates vibration on any click
    func generateFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    
    ///This function shows any alert message with title and message
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    ///This func dismisses the keyboard on screen tap
    func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    ///This func sets border color, width and corner radius to image
    func setBorderAndRadiusToImage(image: UIImageView, borderColor: UIColor, borderWidth: CGFloat, radius: CGFloat) {
        image.layer.borderColor = borderColor.cgColor
        image.layer.borderWidth = borderWidth
        image.layer.cornerRadius = radius
        image.clipsToBounds = true
    }
    
    
    
    
    
    /// Shows a Toast Message in UIView Controller
    /// - Parameters:
    ///   - message: String Message
    ///   - font: UIFont
    ///   - toastColor: UIColor
    ///   - toastBackground: UIColor
    func showToast(message : String, font: UIFont, toastColor: UIColor,
                   toastBackground: UIColor) {
        let toastLabel = UILabel()
        toastLabel.textColor = toastColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.backgroundColor = toastBackground
        
        toastLabel.clipsToBounds  =  true
        
        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2),
                                  y: self.view.frame.height - (toastHeight * 3),
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
    
}



//MARK: - UIView Extension
extension UIView {
    
    ///This function anchors views
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    ///This func centers view in X
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    ///This func centers view in Y
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    ///This func sets dimensions of a view
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    ///This func sets height of a view
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    ///This func sets width of a view
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    
    
    
    /// Adds Rounded Corners to UIView
    /// - Parameters:
    ///   - corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]
    ///   - radius: CGFloat
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    
    /// Function to pin view to edges: Use this to add Scroll View first and then Stack View on it.
    /// - Parameters:
    ///   - constant: Constants is CGFloat
    ///   - superview: A view
    func pinToEdges(constant: CGFloat = 0, inView superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
    }
    
    
    
    
    /// Shows Tap Animation on a uibutton
    /// - Parameter completionBlock: escapes completion and add own code
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                       }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                           }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
                       }
    }
    
    
    /// Adds tilting effect to a uiView
    /// - Parameter vw: UIView
    func addParallaxToView(vw: UIView) {
        let amount = 100
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
    
    func cornerRadius(usingCorners corners: UIRectCorner, cornerRadii: CGSize) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
    
    
}



//MARK: - UIButton Extension
extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: image.size.width / 2)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
        
    }
    
    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 5, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
}





//MARK: - UIIMageView Extension
extension UIImageView {
    
    func addGradientBorder(imageName: UIImageView, lineWidth: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero, size: imageName.frame.size)
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(ovalIn: imageName.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        imageName.layer.addSublayer(gradient)
    }
    
    
}




//MARK: - UILabel Extension
extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
    
    func setSfSymbolBeforeTextUILabel(_ text: String, prependedBySymbolNameed symbolSystemName: String, font: UIFont? = nil) {
        if #available(iOS 13.0, *) {
            if let font = font { self.font = font }
            let symbolConfiguration = UIImage.SymbolConfiguration(font: self.font)
            let symbolImage = UIImage(systemName: symbolSystemName, withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
            let symbolTextAttachment = NSTextAttachment()
            symbolTextAttachment.image = symbolImage
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(attachment: symbolTextAttachment))
            attributedText.append(NSAttributedString(string: " " + text))
            self.attributedText = attributedText
        } else {
            self.text = text // fallback
        }
    }
    
}



//MARK: - String Extension
extension String {
    
    
    /// Converts emoji string
    /// - Returns: returns an image from string
    func image(with ofsize: CGFloat) -> UIImage? {
        let size = CGSize(width: ofsize, height: ofsize)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: ofsize)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    //Usage: let strDate = "2020-08-10 15:00:00"
    //let date = strDate.toDate(format: "yyyy-MM-dd HH:mm:ss")
    /// Converts String to Date
    /// - Parameter format: String as Input
    /// - Returns: Date
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
    
    
    
    
    
    
    /// Checks if the String is a proper Email
    /// - Parameter expression: The string to check
    /// - Returns: Boolean
    func matches(_ expression: String) -> Bool {
        if let range = range(of: expression, options: .regularExpression, range: nil, locale: nil) {
            return range.lowerBound == startIndex && range.upperBound == endIndex
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    
    
    
    
    /// Converts String ot INT
    /// - Returns: Integer
    func toInt() -> Int {
        Int(self)!
    }
    
    func toIntOrNull() -> Int? {
        Int(self)
    }
    
    
    
}




//MARK: - Date Extensions
extension Date {
    
    //Usage
    //let date = strDate.toDate(format: "yyyy-MM-dd HH:mm:ss")
    //let strDate2 = date?.toString(format: "yyyy-MM-dd HH:mm:ss")
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}



//MARK: - UITextFields
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



//MARK: - UIColor Extensios
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}



//MARK: - Navigation Controller
extension UINavigationController {
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}





//MARK: - For Custom Pop Up
@objc class ClosureSleeve: NSObject {
    let closure: ()->()
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    @objc func invoke () {
        closure()
    }
}

extension UIColor {
    /// For POPUP
    static let cFullViewBg = UIColor.orange
    static let cPopUpBg = UIColor.purple
    static let cPopUpText = UIColor.black
    static let cBtnFontColor = UIColor.black
    static let cBtnBg = UIColor.white
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}


extension UIViewController{
    
    private func getFontFamily() -> UIFont{
        return UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
    }
    
    @available(iOS 13.0, *)
    private func getStatusBarHeight() -> CGFloat{
        var heightToReturn: CGFloat = 0.0
        for window in UIApplication.shared.windows {
            if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                heightToReturn = height
            }
        }
        return heightToReturn
    }
    
    func topPopUp(strText: String, imgName: String, duration: Int){
        
        var topBarHeight = CGFloat()
        
        if #available(iOS 13, *) {
            topBarHeight = getStatusBarHeight() + (self.navigationController?.navigationBar.frame.height ?? 0.0) + 20
        }else{
            topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0) + 20
        }
        
        let btnAlert = UIButton(frame:CGRect(x:10, y:topBarHeight, width:UIScreen.main.bounds.width - 20, height:50))
        btnAlert.setTitle(strText, for: .normal)
        btnAlert.titleLabel?.lineBreakMode = .byTruncatingTail
        btnAlert.setImage(UIImage(named: imgName), for: .normal)
        btnAlert.setTitleColor(.black, for: .normal)
        btnAlert.backgroundColor = .white
        btnAlert.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: (btnAlert.bounds.width - 45))
        btnAlert.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        btnAlert.titleLabel?.numberOfLines = 0
        btnAlert.layer.cornerRadius = CONST.CORNER_RADII
        btnAlert.titleLabel?.textAlignment = .left
        self.view.addSubview(btnAlert)
        
        let time = duration
        let whenWhen = DispatchTime.now() + DispatchTimeInterval.seconds(time)
        DispatchQueue.main.asyncAfter(deadline: whenWhen){
            btnAlert.removeFromSuperview()
        }
    }
    
    func popUpWithButtons(imgName: String, btnYesText: String, btnNoText: String,
                          yesButtonBGColor: UIColor,
                          noButtonBGColor: UIColor,
                          viewBorderColor: UIColor,
                          txtMessage: String, numOfButtons: Int, completion: @escaping (_ success: Bool) -> ()) {
        
        if imgName == ""{
            print("image name cannot be blank")
            return
        }
        
        let screenRect = UIScreen.main.bounds
        let bgView = UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: screenRect.size.width, height: screenRect.size.height))
        bgView.backgroundColor = .black
        bgView.alpha = 0.5
        
        
        let alignCenter = (screenRect.size.height/2)-250/2
        let vAlert = UIView.init(frame: CGRect(x: 15, y: alignCenter, width: screenRect.width - 30, height: 250))
        vAlert.backgroundColor = .white
        vAlert.layer.borderColor = viewBorderColor.cgColor
        vAlert.layer.cornerRadius = CONST.CORNER_RADII
        vAlert.layer.borderWidth = 2.0
        
        let imgAlert = UIImageView.init(frame: CGRect(x: (vAlert.frame.width / 2) - 15, y: 30, width: 35, height: 35))
        imgAlert.image = UIImage(systemName: imgName)
        imgAlert.tintColor = .black
        
        let vButtons = UIView.init(frame: CGRect(x: vAlert.frame.origin.x + 30, y: vAlert.frame.height - 65, width: vAlert.frame.width - 90, height: 40))
        
        var btnNo = UIButton()
        var btnYes = UIButton()
        
        if (numOfButtons == 1){
            btnYes = .init(frame: CGRect(x: 0, y: 0, width: vButtons.frame.width, height: vButtons.frame.height))
        }
        else if (numOfButtons == 2){
            btnNo = .init(frame: CGRect(x: 0, y: 0, width: (vButtons.frame.width / 2) - 10, height: vButtons.frame.height))
            vButtons.addSubview(btnNo)
            
            btnYes = .init(frame:CGRect(x: btnNo.frame.origin.x + btnNo.frame.width + 20, y: 0, width: (vButtons.frame.width / 2) - 10, height: vButtons.frame.height))
        }
        
        btnNo.setTitle(btnNoText.uppercased(), for: .normal)
        btnNo.backgroundColor = noButtonBGColor
        btnNo.titleLabel?.font = getFontFamily()
        btnNo.setTitleColor(.white, for: .normal)
        btnNo.layer.cornerRadius = CONST.CORNER_RADII
        
        btnNo.addAction(for: .touchUpInside) {
            bgView.removeFromSuperview()
            vAlert.removeFromSuperview()
            completion(false)
        }
        
        btnYes.setTitle(btnYesText.uppercased(), for: .normal)
        btnYes.backgroundColor = yesButtonBGColor
        btnYes.titleLabel?.font = getFontFamily()
        btnYes.setTitleColor(.white, for: .normal)
        btnYes.layer.cornerRadius = CONST.CORNER_RADII
        
        btnYes.addAction(for: .touchUpInside) {
            bgView.removeFromSuperview()
            vAlert.removeFromSuperview()
            completion(true)
        }
        
        let lblAlertText = UILabel.init(frame: CGRect(x: vButtons.frame.origin.x, y: imgAlert.frame.origin.y + imgAlert.frame.height + 10, width: vButtons.frame.width, height: btnYes.frame.height))
        lblAlertText.text = txtMessage
        lblAlertText.textColor = .cPopUpText
        lblAlertText.numberOfLines = 0
        lblAlertText.textAlignment = .center
        lblAlertText.font = getFontFamily()
        
        vAlert.addSubview(imgAlert)
        vAlert.addSubview(lblAlertText)
        vButtons.addSubview(btnYes)
        vAlert.addSubview(vButtons)
        view.addSubview(bgView)
        view.addSubview(vAlert)
    }
}

//MARK: - End Of Custom POPUP

