//
//  SizePanel.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

protocol SizePanelViewDelegate: AnyObject {
	func updateSize(size: Int)
}

class SizePanelView: UIView {

	weak var delegate: SizePanelViewDelegate?

	let sizeArr = [10, 20, 30, 50, 100]
	let marginRatio: CGFloat = 0.05

	let buttonWidth: CGFloat
	let marginWidth: CGFloat

	override init(frame: CGRect) {
		let buttonCount = sizeArr.count
		let marginCount = buttonCount + 1
		self.marginWidth = marginRatio * frame.width
		let totalButtonWidth = frame.width - marginWidth * CGFloat(marginCount)
		self.buttonWidth = totalButtonWidth / CGFloat(buttonCount)
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {
		//backgroundColor = .black
		for i in 0..<sizeArr.count {
			sizeButton(index: i, name: String(sizeArr[i]))
		}
	}



	private func sizeButton(index: Int, name: String) {
		let startX = marginWidth + (buttonWidth + marginWidth) * CGFloat(index)
		let buttoOrigin = CGPoint(x: startX, y: (frame.height - buttonWidth) * 0.5)
		let button = UIButton(frame: CGRect(origin: buttoOrigin, size: CGSize(width: buttonWidth, height: buttonWidth)))
		button.tag = index
		button.addTarget(self, action: #selector(onTap(button:)), for: .touchDown)
		button.setTitle(name, for: .normal)
		button.backgroundColor = .systemBlue
		addSubview(button)
	}

	@objc
	func onTap(button: UIButton) {
		let size = sizeArr[button.tag]
		print(size)
		delegate?.updateSize(size: size)
	}


}
