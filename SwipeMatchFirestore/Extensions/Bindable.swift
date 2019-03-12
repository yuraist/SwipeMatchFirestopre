//
//  Bindable.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 12/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import Foundation

class Bindable<T> {
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: ((T?) -> ())?
  
  func bind(observer: @escaping (T?) -> ()) {
    self.observer = observer
  }
}
