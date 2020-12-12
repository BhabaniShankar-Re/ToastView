//
//  Toastview.swift
//  SwiftToast
//
//  Created by Summit on 11/12/20.
//

import UIKit

class Toastview {
    static private var _toastView: Toastview!
    
    fileprivate static var _font: UIFont = UIFont.preferredFont(forTextStyle: .callout)
    fileprivate static var _toastBackgroundColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    fileprivate static var _fontColor: UIColor = .black
    
    static func configure() {
        _toastView = Toastview()
    }
    
    static func configure(_ backgroundColor: UIColor, _ fontColor: UIColor, font: UIFont) {
        configure()
        _font = font
        _fontColor = fontColor
        _toastBackgroundColor = backgroundColor
    }
    
    static func show(message: String?) {
        DispatchQueue.main.async {
            _toastView.show(message: message)
        }
    }
    
    static func show(message: String?, backgroundColor: UIColor?, fontColor: UIColor?) {
        _toastView.show(message: message, bgColor: backgroundColor, fontColor: fontColor)
    }
    
    private var window: UIWindow? {
        UIApplication.shared.windows.filter({ return $0.isKeyWindow }).first
    }
    
    private var bottomSpacing: CGFloat = 40
    private weak var bottomConstraint: NSLayoutConstraint?
    private var isPresented: Bool = false
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateValue(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func updateValue(_ notification: Notification) {
        guard let keybaordRectonEnd = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, let keyboardRectatBegin = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else { fatalError("Keybaord notification value can't convert to rect value") }
        
        if keybaordRectonEnd.minY < keyboardRectatBegin.minY {
            bottomSpacing = keybaordRectonEnd.height + 20
        }else if keybaordRectonEnd.minY > keyboardRectatBegin.minY {
            if keybaordRectonEnd.minY == self.window?.frame.maxY {
                bottomSpacing = 40
            }else {
                bottomSpacing = keybaordRectonEnd.height + 20
            }
        }
        
        if isPresented {
            bottomConstraint?.constant = bottomSpacing
            UIView.animate(withDuration: 0.3) {
                self.window?.layoutIfNeeded()
            }
        }

        
    }
    
    private func show(message: String?, bgColor: UIColor? = nil, fontColor: UIColor? = nil) {
        
        let toastMessageView = ToastMessage(bgColor, fontColor)
        toastMessageView.messagelabel.text = message ?? "..."
        guard let superView = self.window else { return }
        
        isPresented = true
        
            superView.addSubview(toastMessageView)
            toastMessageView.translatesAutoresizingMaskIntoConstraints = false
            toastMessageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            bottomConstraint = superView.bottomAnchor.constraint(equalTo: toastMessageView.bottomAnchor, constant: bottomSpacing)
            bottomConstraint?.isActive = true
            toastMessageView.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: 30).isActive = true
            superView.trailingAnchor.constraint(greaterThanOrEqualTo: toastMessageView.trailingAnchor, constant: 30).isActive = true
            
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseIn, animations: {
            toastMessageView.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.6, delay: 3.0, options: .curveEaseOut, animations: {
                toastMessageView.alpha = 0.0
            }) { (_) in
                toastMessageView.removeFromSuperview()
                self.isPresented = false
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



fileprivate class ToastMessage: UIView {
    
    fileprivate var messagelabel = UILabel()
    
    init(_ bgColor: UIColor?, _ fontClr: UIColor?){
        super.init(frame: .zero)
        setup()
        if bgColor != nil { backgroundColor = bgColor }
        if fontClr != nil { messagelabel.textColor = fontClr }
    }
    
    required init?(coder: NSCoder) {
        // super.init(coder: coder)
        fatalError("Nscodding is not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    private func setup() {
        messagelabel.numberOfLines = 0
        messagelabel.textAlignment = .center
        messagelabel.font = Toastview._font
        messagelabel.textColor = Toastview._fontColor
        backgroundColor = Toastview._toastBackgroundColor
        self.alpha = 0.0
        setupConstriants()
    }
    
    
    private func setupConstriants() {
        self.addSubview(messagelabel)
        messagelabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [messagelabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        self.bottomAnchor.constraint(equalTo: messagelabel.bottomAnchor, constant: 10),
        messagelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        self.trailingAnchor.constraint(equalTo: messagelabel.trailingAnchor, constant: 20)])
    }
    
}
