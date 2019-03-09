//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    distribution = .fillEqually
    heightAnchor.constraint(equalToConstant: 100).isActive = true
  
    let subviews = [#imageLiteral(resourceName: "reload"),#imageLiteral(resourceName: "cancel"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "like"),#imageLiteral(resourceName: "lightning")].map { (img) -> UIView in
      let button = UIButton(type: .system)
      button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
    }
    
    subviews.forEach { (view) in
      addArrangedSubview(view)
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
