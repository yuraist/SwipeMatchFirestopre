//
//  CardViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
  func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
  let imageName: String
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment
}
