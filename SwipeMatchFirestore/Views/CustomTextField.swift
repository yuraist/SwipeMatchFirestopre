//
//  CustomTextField.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 10/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  
  let padding: CGFloat
  
  init(padding: CGFloat) {
    self.padding = padding
    super.init(frame: .zero)
    
    self.layer.cornerRadius = 24
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override var intrinsicContentSize: CGSize {
    return .init(width: 0, height: 50)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
