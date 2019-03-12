//
//  RegistrationController.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 10/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {
  
  // UI Components
  let selectPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 275).isActive = true
    button.layer.cornerRadius = 16
    button.clipsToBounds = true
    button.imageView?.contentMode = .scaleAspectFill
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    return button
  }()
  
  @objc func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
  }
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24)
    tf.placeholder = "Enter full name"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
    return tf
  }()
  
  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24)
    tf.placeholder = "Enter email"
    tf.keyboardType = .emailAddress
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
    return tf
  }()
  
  let passwordTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24)
    tf.placeholder = "Enter password"
    tf.isSecureTextEntry = true
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
    return tf
  }()
  
  @objc fileprivate func handleTextChange(textField: UITextField) {
    if textField == fullNameTextField {
      registrationViewModel.fullName = textField.text
    } else if textField == emailTextField {
      registrationViewModel.email = textField.text
    } else {
      registrationViewModel.password = textField.text
    }
  }
  
  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
    // Disable button
    button.alpha = 0.5
    button.isEnabled = false
    
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    
    button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    return button
  }()
  
  let registeringHUD = JGProgressHUD(style: .dark)
  
  @objc fileprivate func handleRegister() {
    handleTapDismiss()
    
    registrationViewModel.performRegistration { [weak self] (err) in
      if let err = err {
        self?.showHUDWithError(error: err)
        return
      }
    }
  }
  
  fileprivate func showHUDWithError(error: Error) {
    registeringHUD.dismiss()
    
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Failed registration"
    hud.detailTextLabel.text = error.localizedDescription
    hud.show(in: self.view)
    hud.dismiss(afterDelay: 2)
  }
  
  let gradientLayer = CAGradientLayer()
  
  lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      registerButton
      ])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    return stackView
  }()
  
  lazy var overallStackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    verticalStackView
    ])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupGradientLayer()
    setupLayout()
    
    setupTapGesture()
    setupRegistrationViewModelObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNotificationObservers()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = view.bounds
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if self.traitCollection.verticalSizeClass == .compact {
      overallStackView.axis = .horizontal
    } else {
      overallStackView.axis = .vertical
    }
  }
  
  fileprivate func setupGradientLayer() {
    let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
    
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0, 1]
    gradientLayer.frame = view.bounds
    
    view.layer.addSublayer(gradientLayer)
  }
  
  fileprivate func setupLayout() {
    view.addSubview(overallStackView)
    overallStackView.axis = .vertical
    overallStackView.spacing = 8
    overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
  }
  
  fileprivate func setupNotificationObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc fileprivate func handleKeyboardShow(notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.cgRectValue
    
    let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
    let difference = keyboardFrame.height - bottomSpace
    self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 16)
  }
  
  @objc fileprivate func handleKeyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
  }
  
  fileprivate func setupTapGesture() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
  }
  
  @objc fileprivate func handleTapDismiss() {
    view.endEditing(true)
  }
  
  // MARK: - Registration View Model
  
  let registrationViewModel = RegistrationViewModel()
  
  fileprivate func setupRegistrationViewModelObserver() {
    registrationViewModel.bindableIsFormValid.bind { [unowned self] (isFormValid) in
      guard let isFormValid = isFormValid else { return }
      
      self.registerButton.isEnabled = isFormValid
      
      if isFormValid {
        self.registerButton.alpha = 1
      } else {
        self.registerButton.alpha = 0.5
      }
    }
    
    registrationViewModel.bindableImage.bind { [unowned self] img in
      self.selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    registrationViewModel.bindableIsRegistering.bind { [unowned self] (isRegistering) in
      if isRegistering == true {
        self.registeringHUD.textLabel.text = "Register"
        self.registeringHUD.show(in: self.view)
      } else {
        self.registeringHUD.dismiss()
      }
    }
  }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    registrationViewModel.bindableImage.value = info[.originalImage] as? UIImage
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
