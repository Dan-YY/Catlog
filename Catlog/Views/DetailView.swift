//
//  DetailView.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

class DetailView: UIView {

	let catInfo: CatInfo
	let buttonHeightToWidthRatio: CGFloat = 0.15
	let marginRatio: CGFloat = 0.1
	var edgeMargin: CGFloat { frame.width * marginRatio }
	var imageMaxWidth: CGFloat { frame.width - edgeMargin * 2.0 }
	var buttonHeight: CGFloat { imageMaxWidth * buttonHeightToWidthRatio }
	var buttonRect: CGRect { CGRect(x: edgeMargin, y: edgeMargin, width: imageMaxWidth, height: buttonHeight)}
	var imageRect: CGRect { CGRect(x: edgeMargin, y: edgeMargin * 2.0 + buttonHeight, width: imageMaxWidth, height: imageMaxWidth) }
	var textViewRect: CGRect{ CGRect(x: edgeMargin, y: edgeMargin * 3.0 + imageMaxWidth + buttonRect.height, width: imageMaxWidth, height: frame.height - edgeMargin * 4.0 - imageMaxWidth - buttonHeight)}



	init(frame: CGRect, catInfo: CatInfo) {
		self.catInfo = catInfo
		super.init(frame: frame)
		commonInit(catInfo: catInfo)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit(catInfo: CatInfo) {
		setupBlackCoverButton()
		setupBackButton()
		setupCatImage(urlStr: catInfo.url, width: catInfo.width, height: catInfo.height)
		setupCatText(catInfo: catInfo)
	}

	private func setupBlackCoverButton() {
		let blackCoverButton = UIButton(frame: frame)
		blackCoverButton.backgroundColor = .white
		blackCoverButton.alpha = 0.9
		blackCoverButton.addTarget(self, action: #selector(onTap), for: .touchDown)
		addSubview(blackCoverButton)
	}

	private func setupBackButton() {
		let backButton = UIButton(frame: buttonRect)
		backButton.backgroundColor = .systemYellow
		backButton.alpha = 0.9
		backButton.setTitle("Back", for: .normal)
		backButton.addTarget(self, action: #selector(onTap), for: .touchDown)
		addSubview(backButton)
	}

	private func setupCatImage(urlStr: String, width: Int, height: Int) {
		let catImageView = UIImageView(frame: imageRect)
		let imageCenter = catImageView.center
		guard let url = URL(string: urlStr) else { return }
		catImageView.loadImageFrom(url: url)
		catImageView.backgroundColor = .systemTeal
		print(width, height)
		var displayWidth: CGFloat
		var displayHeight: CGFloat
		if width > height {
			displayWidth = imageMaxWidth
			displayHeight = displayWidth * CGFloat(height) / CGFloat(width)
		} else {
			displayHeight = imageMaxWidth
			displayWidth = displayHeight * CGFloat(width) / CGFloat(height)
		}
		print(displayHeight, displayWidth)
		catImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: displayWidth, height: displayHeight))
		catImageView.center = imageCenter
		addSubview(catImageView)
	}



	private func setupCatText(catInfo: CatInfo) {
		let textField = UITextView(frame: textViewRect)
		textField.isEditable = false
		//textField.backgroundColor = .clear
		textField.font = UIFont.systemFont(ofSize: 22)
		textField.text = catInfo.textValue()
		addSubview(textField)
	}

	@objc
	func onTap() {
		subviews.forEach { $0.removeFromSuperview() }
		removeFromSuperview()
	}

}
