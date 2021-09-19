//
//  GridList.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

protocol GirdListDelegate: AnyObject {
	func setupDetailView(infoIndex: Int)
}

class GridListView: UIView {

	weak var delegate: GirdListDelegate?
	let gridPerCol = 5

	let scrollView: UIScrollView
	let gridWidthHeight: CGFloat
	var girdOriginXArr = [CGFloat]()

	var gridCount: Int = 0
	var colCount: Int { gridCount / gridPerCol }
	var scrollableHeight: CGFloat { CGFloat(colCount) * gridWidthHeight }


	override init(frame: CGRect) {
		let gridWidth: CGFloat = frame.width / CGFloat(gridPerCol)
		self.gridWidthHeight = gridWidth
		self.scrollView = UIScrollView(frame: CGRect(origin: CGPoint.zero, size: frame.size))

		for i in 0..<5 {
			self.girdOriginXArr.append(CGFloat(i) * gridWidth)
		}

		super.init(frame: frame)
		commonInit()
	}

	func updateScrollView(infoArr: [CatInfo], size: Int) {
		gridCount = size
		scrollView.contentSize = CGSize(width: frame.size.width, height: scrollableHeight)
		cleanScrollView()
		updateListInfo(infoArr: infoArr, size: size)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	private func commonInit() {
		self.scrollView.canCancelContentTouches = true
		addSubview(self.scrollView)
	}

	private func setupScrollView() {
		scrollView.contentSize = CGSize(width: frame.width, height: CGFloat(colCount) * gridWidthHeight)
		self.scrollView.canCancelContentTouches = true
		addSubview(self.scrollView)
	}


	@objc
	func onTap(button: UIButton) {
		print(button.tag)
		delegate?.setupDetailView(infoIndex: button.tag)
	}


}

// MARK: scrollViewControll()
extension GridListView {
	private func cleanScrollView() { scrollView.subviews.forEach { $0.removeFromSuperview() } }

	private func updateListInfo(infoArr: [CatInfo], size: Int) {
		for i in 0..<infoArr.count {
			gridButton(index: i, name: infoArr[i].id) }
	}

	private func gridButton(index: Int, name: String) {
		let rowIndex = index % gridPerCol
		let colIndex = index / gridPerCol
//		print("index:", index, " ", rowIndex, " ", colIndex)
//		print(gridWidthHeight)
		let buttoOrigin = CGPoint(x: CGFloat(rowIndex) * gridWidthHeight, y: CGFloat(colIndex) * gridWidthHeight)
		let button = UIButton(frame: CGRect(origin: buttoOrigin, size: CGSize(width: gridWidthHeight, height: gridWidthHeight)))
		button.tag = index
		button.addTarget(self, action: #selector(onTap(button:)), for: .touchDown)
		button.setTitle(name, for: .normal)
		button.setTitleColor(.black, for: .normal)
		scrollView.addSubview(button)

		button.backgroundColor = .clear
	}
}
