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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 10
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
