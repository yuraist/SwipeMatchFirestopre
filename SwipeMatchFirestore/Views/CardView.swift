//
//  CardView
//  SwipeMatchFirestore
//
//  Created by Юрий Истомин on 09/03/2019.
//  Copyright © 2019 Treedo. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  var cardViewModel: CardViewModel! {
    didSet {
      let imageName = cardViewModel.imageNames.first ?? ""
      imageView.image = UIImage(named: imageName)
      informationLabel.attributedText = cardViewModel.attributedString
      informationLabel.textAlignment = cardViewModel.textAlignment
      
      (0..<cardViewModel.imageNames.count).forEach { (_) in
        let view = UIView()
        view.backgroundColor = deselectedBarColor
        barsStackView.addArrangedSubview(view)
      }
      barsStackView.arrangedSubviews.first?.backgroundColor = .white
    }
  }
  
  // Encapsulation
  fileprivate let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  fileprivate let informationLabel = UILabel()
  fileprivate let gradientLayer = CAGradientLayer()
  
  // Configurations
  fileprivate let threshold: CGFloat = 100
  fileprivate let deselectedBarColor = UIColor(white: 0, alpha: 0.1)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupLayout()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    addGestureRecognizer(tapGesture)
  }
  
  fileprivate func setupLayout() {
    layer.cornerRadius = 10
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    setupBarsStackView()
    
    setupGradientLayer()
    
    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    informationLabel.numberOfLines = 0
    informationLabel.textColor = .white
    informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
  }
  
  fileprivate let barsStackView = UIStackView()
  
  fileprivate func setupBarsStackView() {
    addSubview(barsStackView)
    barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                         padding: .init(top: 8, left: 8, bottom: 0, right: 8),
                         size: .init(width: 0, height: 4))
    barsStackView.spacing = 4
    barsStackView.distribution = .fillEqually
  }
  
  fileprivate func setupGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.5, 1.1]
    
    layer.addSublayer(gradientLayer)
  }
  
  override func layoutSubviews() {
    gradientLayer.frame = frame
  }
  
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      superview?.subviews.forEach({ (subview) in
        subview.layer.removeAllAnimations()
      })
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
    let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
    let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
      if shouldDismissCard {
        self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
      } else {
        self.transform = .identity
      }
    }) { (_) in
      self.transform = .identity
      if shouldDismissCard {
        self.removeFromSuperview()
      }
    }
  }
  
  var imageIndex = 0
  
  @objc fileprivate func handleTap(_ gesture: UITapGestureRecognizer) {
    let tapLocation = gesture.location(in: nil)
    let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2
    
    if shouldAdvanceNextPhoto {
      imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
    } else {
      imageIndex = max(0, imageIndex - 1)
    }
    
    let imageName = cardViewModel.imageNames[imageIndex]
    imageView.image = UIImage(named: imageName)
    barsStackView.arrangedSubviews.forEach { (view) in
      view.backgroundColor = deselectedBarColor
    }
    barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
