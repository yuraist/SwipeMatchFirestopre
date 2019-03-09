//
//  CardView
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  fileprivate let imageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "ava"))
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  // Configurations
  fileprivate let threshold: CGFloat = 100
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 10
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
  }
  
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .changed:
      handleChanged(gesture)
    case .ended:
      handleEnded(gesture)
    default:
      ()
    }
  }
  
  fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: nil)
    let degrees: CGFloat = translation.x / 20
    let angle = degrees * .pi / 180
    
    let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
    transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
  }
  
  fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
    let shouldDismissCard = gesture.translation(in: nil).x > threshold
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
      if shouldDismissCard {
        self.frame = CGRect(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
      } else {
        self.transform = .identity
      }
    }) { (_) in
      self.transform = .identity
      self.frame = CGRect(x: 0, y: 0,
                          width: self.superview!.frame.width,
                          height: self.superview!.frame.height)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
