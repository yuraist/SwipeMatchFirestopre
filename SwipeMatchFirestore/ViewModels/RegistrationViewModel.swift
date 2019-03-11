//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 11/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class RegistrationViewModel {
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
  
  fileprivate func checkFormValidity() {
    let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
    isFormValidObserver?(isFormValid)
  }
  
  var isFormValidObserver: ((Bool) -> ())?
}
