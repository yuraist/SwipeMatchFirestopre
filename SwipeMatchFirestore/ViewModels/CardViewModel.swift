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

class CardViewModel {
  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment
  
  init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
    self.imageNames = imageNames
    self.attributedString = attributedString
    self.textAlignment = textAlignment
  }
  
  fileprivate var imageIndex = 0 {
    didSet {
      let imageName = imageNames[imageIndex]
      let image = UIImage(named: imageName)
      imageIndexObserver?(imageIndex, image)
    }
  }
  
  var imageIndexObserver: ((Int, UIImage?) -> ())?
  
  
  func advanceToNextPhoto() {
    imageIndex = min(imageIndex + 1, imageNames.count - 1)
  }
  
  func goToPreviousPhoto() {
    imageIndex = max(0, imageIndex - 1)
  }
}
