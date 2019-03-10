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
  
  let cardViewModels: [CardViewModel] = {
    let producers = [
      User(name: "Yura", age: 20, profession: "iOS Developer", imageNames: ["yura_1", "yura_2"]),
      User(name: "Polina", age: 21, profession: "UX/UI Designer", imageNames: ["polina_1", "polina_2", "polina_3"]),
      Advertiser(title: "To Do App", brandName: "Treedo Studio", posterPhotoName: "ipad_1")
    ] as [ProducesCardViewModel]
    
    let viewModels = producers.map({ return $0.toCardViewModel() })
    return viewModels
  }()
  
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
      cardView.cardViewModel = cardViewModel
      cardsDeckView.addSubview(cardView)
      cardView.fillSuperview()
    }
  }
}
