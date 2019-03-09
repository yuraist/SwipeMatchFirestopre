//
//  HomeController.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  
  let topStackView = TopNavigationStackView()
  let cardsDeckView = UIView()
  let buttonsStackView = HomeBottomControlsStackView()
  
  let users = [
    User(name: "Yura", age: 20, profession: "iOS Developer", imageName: "ava"),
    User(name: "Polina", age: 21, profession: "UX/UI Designer", imageName: "polina")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupCards()
  }
  
  // MARK:- Fileprivate
  
  fileprivate func setupLayout() {
    let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
    overallStackView.axis = .vertical
    view.addSubview(overallStackView)
    overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.leadingAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            trailing: view.trailingAnchor)
    
    overallStackView.isLayoutMarginsRelativeArrangement = true
    overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    
    overallStackView.bringSubviewToFront(cardsDeckView)
  }
  
  fileprivate func setupCards() {
    users.forEach { (user) in
      let cardView = CardView(frame: .zero)
      cardView.imageView.image = UIImage(named: user.imageName)
      
      let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
      attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
      attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
      
      cardView.informationLabel.attributedText = attributedText
      
      cardsDeckView.addSubview(cardView)
      cardView.fillSuperview()
    }
  }
}
