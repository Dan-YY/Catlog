//
//  VCFrame.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-19.
//

import UIKit


// MARK: initView
extension ViewController {
	func setupFrame() -> (CGRect, CGRect, CGRect) {
		let screenWidth = view.frame.width
		let screenHeight = view.frame.height
		let topMargin = screenHeight * 0.05
		let leftMargin = screenWidth * 0.0


		let totalHeight = screenHeight - topMargin * 2.0
		let totalWidth = screenWidth - leftMargin * 2.0


		let frameHeightRatioArr: [CGFloat] = [0.7, 0.2, 0.1]


		let gridListHeight = frameHeightRatioArr[0] * totalHeight
		let pagePanelHeight = frameHeightRatioArr[1] * totalHeight
		let sizePanelHeight = frameHeightRatioArr[2] * totalHeight

		let gridListRectOrign = CGPoint(x: leftMargin, y: topMargin)
		let gridListRectSize = CGSize(width: totalWidth, height: gridListHeight)
		let gridListRect = CGRect(origin: gridListRectOrign, size: gridListRectSize)

		let pagePanelRectOrign = CGPoint(x: leftMargin, y: topMargin + gridListHeight)
		let pagePanelRectSize = CGSize(width: totalWidth, height: pagePanelHeight)
		let pagePanelRect = CGRect(origin: pagePanelRectOrign, size: pagePanelRectSize)

		let sizePanelRectOrign = CGPoint(x: leftMargin, y: topMargin + gridListHeight + pagePanelHeight)
		let sizePanelRectSize = CGSize(width: totalWidth, height: sizePanelHeight)
		let sizePanelRect = CGRect(origin: sizePanelRectOrign, size: sizePanelRectSize)

		return (gridListRect, pagePanelRect, sizePanelRect)
	}
}
