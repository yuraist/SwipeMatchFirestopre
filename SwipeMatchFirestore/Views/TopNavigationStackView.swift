//
//  TopNavigationStackView.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
  
  let settingsButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: #imageLiteral(resourceName: "fire"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    heightAnchor.constraint(equalToConstant: 80).isActive = true
    distribution = .equalCentering
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    fireImageView.contentMode = .scaleAspectFit
    
    settingsButton.setImage(#imageLiteral(resourceName: "user").withRenderingMode(.alwaysOriginal), for: .normal)
    messageButton.setImage(#imageLiteral(resourceName: "comments").withRenderingMode(.alwaysOriginal), for: .normal)
    
    [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach { (button) in
      addArrangedSubview(button)
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
