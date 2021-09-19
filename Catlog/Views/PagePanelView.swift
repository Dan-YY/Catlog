//
//  PagePanel.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

protocol PagePanelViewDelegate: AnyObject {
	func onPageButton(value: Int)
}

class PagePanelView: UIView {

	weak var delegate: PagePanelViewDelegate?

	let arrowButtonWidthRatio: CGFloat = 0.08
	let pageButtonSpacingAndMargeRatio: CGFloat = 0.005
	let spacingWidthRatio: CGFloat = 0.005
	let pageButtonCountDisplayed = 10
	let pageColDisplayed = 3
	let maxInfoCount = 3501 * 3
	let arrowButtonWidth: CGFloat
	let spacingWidth: CGFloat
	let pageButtonWidth: CGFloat
	let pageButtonHeight: CGFloat
	let pageButtonYArr: [CGFloat]

	var pageButtonArr = [UIButton]()
	var pageButtonPerPage: Int { pageButtonCountDisplayed * pageColDisplayed }
	var currentMaxPage: Int { maxInfoCount / size }

	var startIndex = 1
	var size: Int


	init(frame: CGRect, startSize: Int) {
		let arrowButtonWidth = frame.width * arrowButtonWidthRatio
		let spacingWidth: CGFloat = frame.width * spacingWidthRatio
		let spacingCount = pageButtonCountDisplayed + 1
		let totalSpacingWidth = spacingWidth * CGFloat(spacingCount)
		let pageButtonTotalWidth = frame.width - arrowButtonWidth * 2.0 - totalSpacingWidth
		let pageButtonWidth = pageButtonTotalWidth / CGFloat(pageButtonCountDisplayed)
		let pageButtonSpacingAndMarge = pageButtonSpacingAndMargeRatio * frame.height
		let pageButtonTotalHeight = frame.height - pageButtonSpacingAndMarge * 4.0
		let pageButtonHeight = pageButtonTotalHeight / 3.0
		self.arrowButtonWidth = arrowButtonWidth
		self.spacingWidth = spacingWidth
		self.pageButtonWidth = pageButtonWidth
		self.size = startSize
		self.pageButtonHeight = pageButtonHeight
		self.pageButtonYArr = [pageButtonSpacingAndMarge, pageButtonSpacingAndMarge * 2.0 + pageButtonHeight, pageButtonSpacingAndMarge * 3.0 + pageButtonHeight * 2.0]
		print("pageButtonSpacingAndMarge", pageButtonSpacingAndMarge, " pageButtonHeight", pageButtonHeight)
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateSizePerPage(size: Int) {
		self.size = size
		for i in 0..<pageButtonArr.count {
			pageButtonArr[i].setTitle(String(startIndex), for: .normal)
		}
	}

	private func updateButtonValue() {
		for i in 0..<pageButtonArr.count {
			pageButtonArr[i].setTitle(String(startIndex + i), for: .normal)
		}
	}

	private func commonInit() {
		//backgroundColor = .red
		setupArrowButton()
		setupPageButton()
		updateButtonValue()
	}

	private func setupArrowButton() {
		let leftButtonOrigin = CGPoint(x: 0.0, y: 0.0)
		let rightButtonOriginX = CGPoint(x: frame.width - arrowButtonWidth, y: 0.0)
		let buttonSize = CGSize(width: arrowButtonWidth, height: frame.height)

		let leftArrowButton = UIButton(frame: CGRect(origin: leftButtonOrigin, size: buttonSize))
		leftArrowButton.tag = 0
		leftArrowButton.addTarget(self, action: #selector(onArrowButton(button:)), for: .touchDown)
		leftArrowButton.setTitle("<", for: .normal)
		leftArrowButton.backgroundColor = .systemBlue
		addSubview(leftArrowButton)

		let rightArrowButton = UIButton(frame: CGRect(origin: rightButtonOriginX, size: buttonSize))
		rightArrowButton.tag = 1
		rightArrowButton.addTarget(self, action: #selector(onArrowButton(button:)), for: .touchDown)
		rightArrowButton.setTitle(">", for: .normal)
		rightArrowButton.backgroundColor = .systemBlue
		addSubview(rightArrowButton)
	}



	private func setupPageButton() {
		for i in 0..<pageButtonCountDisplayed * pageColDisplayed {
			let button = pageButton(index: i)
			pageButtonArr.append(button)
		}
	}

	private func pageButton(index: Int)-> UIButton {
		let rowIndex = index % pageButtonCountDisplayed
		let colIndex = index / pageButtonCountDisplayed
		let leftMargin = arrowButtonWidth + spacingWidth
		let buttonX: CGFloat = leftMargin + (spacingWidth + pageButtonWidth) * CGFloat(rowIndex)
		let buttonY: CGFloat = pageButtonYArr[colIndex]
		let buttonOrigin = CGPoint(x: buttonX, y: buttonY)
		let buttonSize = CGSize(width: pageButtonWidth, height: pageButtonHeight)
		let pageButton = UIButton(frame: CGRect(origin: buttonOrigin, size: buttonSize))
		pageButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
		pageButton.tag = index
		pageButton.addTarget(self, action: #selector(onPageButton(button:)), for: .touchDown)
		pageButton.backgroundColor = .systemBlue
		addSubview(pageButton)
		return pageButton
	}

	@objc
	func onArrowButton(button: UIButton) {
		if button.tag == 0 { //left
			print("left")
		} else if button.tag == 1 { //right
			print("right")
		}

		if button.tag == 0 && startIndex > 1 {
			startIndex -= pageButtonPerPage
			updateButtonValue()
		} else if button.tag == 1 && startIndex < currentMaxPage - 1 {
			startIndex += pageButtonPerPage
			updateButtonValue()
		}

	}

	@objc
	func onPageButton(button: UIButton) {
		let buttonValue = button.tag + startIndex
		print("tag: ", button.tag, " value: ", buttonValue)
		delegate?.onPageButton(value: buttonValue)
	}


}
