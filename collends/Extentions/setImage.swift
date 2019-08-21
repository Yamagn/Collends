//
//  setImage.swift
//  collends
//
//  Created by ymgn on 2019/08/21.
//  Copyright © 2019 ymgn. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with url: URL) {
        self.kf.setImage(with: url) { [weak self] image, error, _, _ in
            if error == nil, let image = image {
                self?.image = image
            }
            else {
                print(error)
            }
        }
    }
}
