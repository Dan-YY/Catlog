//
//  ViewController.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import UIKit

class ViewController: UIViewController {

	var pagePanel: PagePanelView!
	var sizePanel: SizePanelView!
	var gridList: GridListView!

	let networkManager = NetworkManager.shared()

	var totalPageCount: Int?
	var currentPage: Int = 1

	var size: Int = 50 { didSet { updatePageSetting() }}
	var page: Int = 1 { didSet { updatePageSetting() }}

	var catInfoArr: [CatInfo]?

	override func viewDidLoad() {
		super.viewDidLoad()
		networkManager.delegate = self
		updatePageSetting()
		initView()
	}

}

// MARK: USER InputEvent / network
extension ViewController: NetworkResponseDelegate {
	func updatePageSetting() {
		print("on update page setting")
		networkManager.request(size: size, page: page) }

	func onNetworkResponse(result: [CatInfo]) {
		catInfoArr = result
		print(result.count, size)
		print("on update page start")
		gridList.updateScrollView(infoArr: result, size: size)
	}
}


// MARK: initView
extension ViewController {
	private func initView() {
		let (gridListRect, pagePanelRect, sizePanelRect) = setupFrame()
		gridList = GridListView(frame: gridListRect)
		gridList.delegate = self
		view.addSubview(gridList)
		pagePanel = PagePanelView(frame: pagePanelRect, startSize: size)
		pagePanel.delegate = self
		view.addSubview(pagePanel)
		sizePanel = SizePanelView(frame: sizePanelRect)
		sizePanel.delegate = self
		view.addSubview(sizePanel)
		print("done")
	}
}


extension ViewController: GirdListDelegate {
	func setupDetailView(infoIndex: Int) {
		guard let catInfoArr = catInfoArr else { return }
		let catInfo = catInfoArr[infoIndex]
		let detailView = DetailView(frame: view.frame, catInfo: catInfo)
		view.addSubview(detailView)
	}
}

extension ViewController: SizePanelViewDelegate {
	func updateSize(size: Int) { self.size = size }
}

extension ViewController: PagePanelViewDelegate {
	func onPageButton(value: Int) { self.page = value }
}

