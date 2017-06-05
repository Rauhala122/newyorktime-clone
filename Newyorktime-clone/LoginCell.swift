//
//  LoginCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    var loginController: LoginController?
    
    let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.frame = CGRect(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2, width: 50, height: 50)
        view.isHidden = true
        view.alpha = 1.0
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let emailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "email-icon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Your Email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let passImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "pass-icon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let passField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setActivityView()
        setImage()
        setEmailView()
        setEmailField()
        setEmailIcon()
        setPassView()
        setPassField()
        setPassIcon()
        setButton()
    }
    
    func handleLogin() {
        
//        guard emailField.text != "" && passField.text != "" else {
//
//            return
//        }
        
        self.loginController?.presentNewsController()
    }
    
    
    func setImage() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 170).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setEmailView() {
        addSubview(emailView)
        emailView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        emailView.widthAnchor.constraint(equalTo: widthAnchor, constant: -24).isActive = true
        emailView.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    func setEmailField() {
        emailView.addSubview(emailField)
        emailField.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 28).isActive = true
        emailField.topAnchor.constraint(equalTo: emailView.topAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: emailView.widthAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    func setEmailIcon() {
        emailView.addSubview(emailImage)
        emailImage.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 0).isActive = true
        emailImage.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 0).isActive = true
        emailImage.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 0).isActive = true
        emailImage.rightAnchor.constraint(equalTo: emailField.leftAnchor, constant: 0).isActive = true
    }
    
    func setPassView() {
        addSubview(passView)
        passView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 20).isActive = true
        passView.widthAnchor.constraint(equalTo: widthAnchor, constant: -24).isActive = true
        passView.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    
    func setPassField() {
        passView.addSubview(passField)
        passField.leftAnchor.constraint(equalTo: passView.leftAnchor, constant: 28).isActive = true
        passField.topAnchor.constraint(equalTo: passView.topAnchor).isActive = true
        passField.widthAnchor.constraint(equalTo: emailView.widthAnchor).isActive = true
        passField.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    func setPassIcon() {
        passView.addSubview(passImage)
        passImage.leftAnchor.constraint(equalTo: passView.leftAnchor, constant: 0).isActive = true
        passImage.topAnchor.constraint(equalTo: passView.topAnchor, constant: 5).isActive = true
        passImage.bottomAnchor.constraint(equalTo: passView.bottomAnchor, constant: -5).isActive = true
        passImage.rightAnchor.constraint(equalTo: passField.leftAnchor, constant: 0).isActive = true
    }
    
    func setButton() {
        addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalTo: passField.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 37).isActive = true
    
    }
    
    func setActivityView() {
        addSubview(activityView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
