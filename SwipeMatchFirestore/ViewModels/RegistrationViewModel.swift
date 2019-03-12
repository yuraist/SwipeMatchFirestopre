//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 11/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class RegistrationViewModel {
  
  var bindableImage = Bindable<UIImage>()
  
  var fullName: String? {
    didSet {
      checkFormValidity()
    }
  }
  
  var email: String? {
    didSet {
      checkFormValidity()
    }
  }
  
  var password: String? {
    didSet {
      checkFormValidity()
    }
  }
  
  var bindableIsFormValid = Bindable<Bool>()
  
  fileprivate func checkFormValidity() {
    bindableIsFormValid.value = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
  }
  
}
