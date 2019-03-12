//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 11/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
  
  var bindableImage = Bindable<UIImage>()
  var bindableIsRegistering = Bindable<Bool>()
  var bindableIsFormValid = Bindable<Bool>()
  
  var fullName: String? { didSet { checkFormValidity() } }
  var email: String? { didSet { checkFormValidity() } }
  var password: String? { didSet { checkFormValidity() } }
  
  func performRegistration(completion: @escaping (Error?) -> ()) {
    guard let email = email, let password = password else { return }
    createUser(withEmail: email, password: password, completion: completion)
  }
  
  fileprivate func createUser(withEmail email: String, password: String, completion: @escaping (Error?) -> ()) {
    bindableIsRegistering.value = true
    
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
      if let err = err {
        completion(err)
        return
      }
      
      self.uploadImage(completion: completion)
    }
  }
  
  fileprivate func uploadImage(completion: @escaping (Error?) -> ()) {
    let filename = UUID().uuidString
    let ref = Storage.storage().reference(withPath: "/images/\(filename)")
    let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.5) ?? Data()
    
    ref.putData(imageData, metadata: nil, completion: { (_, err) in
      if let err = err {
        completion(err)
        return
      }
      
      ref.downloadURL(completion: { (_, err) in
        if let err = err {
          completion(err)
          return
        }
        
        self.bindableIsRegistering.value = false
      })
    })
  }
  
  fileprivate func checkFormValidity() {
    bindableIsFormValid.value = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
  }
  
}
