//
//  NetworkManager.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import Foundation

protocol NetworkResponseDelegate: AnyObject {
	func onNetworkResponse(result: [CatInfo])
}

class NetworkManager {

	weak var delegate: NetworkResponseDelegate?

	private static var sharedNetworkManager: NetworkManager = { NetworkManager() }()

	let prefix = "https://api.thecatapi.com/v1/images/search?"
	let limitStr = "limit="
	let pageStr =  "&page="
	let suffix: String = "&order=Desc"

	private init() { }

	// MARK: - Accessors

	class func shared() -> NetworkManager { sharedNetworkManager }

	public func request(size: Int, page: Int) {

		guard let url = URL(string: urlString(size: size, page: page)) else {
			fatalError("URL error")
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("x-api-key", forHTTPHeaderField: "24be637f-e596-4847-b47a-1791feeea1bd")

		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				self.handleClientError(error: error)
				return
			}

			guard let httpResponse = response as? HTTPURLResponse,
								(200...299).contains(httpResponse.statusCode) else {
				self.handleServerError(response: response)
				return
			}
//
			guard let data = data else {
				self.handleDataError(msg: "empty")
				return
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let result = try decoder.decode([CatInfo].self, from: data)
				DispatchQueue.main.async {
					self.delegate?.onNetworkResponse(result: result)
				}
			} catch let jsonErr {
				self.handleDecodeError(error: jsonErr)
			}
		}
		task.resume()
	}

	private func handleClientError(error: Error) {
		print(error)
	}

	private func handleServerError(response: URLResponse?) {
		print(response ?? "respon is nil")
	}

	private func handleDataError() {
		print("Network Error: data is empty")
	}

	private func handleDataError(msg: String) {
		print("Data Error: ", msg)
	}

	private func handleDecodeError(error: Error) {
		print("Decode Error: ", error)
	}

	private func urlString(size: Int, page: Int) -> String {
		let limitPiece = limitStr + String(size)
		let pagePiece = pageStr + String(page)
		return prefix + limitPiece + pagePiece + suffix
	}

}

