//
//  UIImageViewExtain.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

extension UIImageView {
	func loadImageFrom(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
