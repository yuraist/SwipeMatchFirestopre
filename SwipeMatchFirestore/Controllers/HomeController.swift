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
  
  let cardViewModels = [
    User(name: "Yura", age: 20, profession: "iOS Developer", imageName: "ava").toCardViewModel(),
    User(name: "Polina", age: 21, profession: "UX/UI Designer", imageName: "polina").toCardViewModel()
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
    cardViewModels.forEach { (cardViewModel) in
      let cardView = CardView(frame: .zero)
      cardView.imageView.image = UIImage(named: cardViewModel.imageName)
      cardView.informationLabel.attributedText = cardViewModel.attributedString
      cardView.informationLabel.textAlignment = cardViewModel.textAlignment
      
      cardsDeckView.addSubview(cardView)
      cardView.fillSuperview()
    }
  }
}
