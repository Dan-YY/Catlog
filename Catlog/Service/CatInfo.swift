//
//  CatInfo.swift
//  Catlog
//
//  Created by Dan-YY on 2021-09-18.
//

import Foundation

struct CatInfo: Codable, Printable { 
	let breeds: [Breeds]
	let id: String
	let url: String
	let width: Int
	let height: Int

	func nonBreedsInfo() -> String {
		var str = "id: " + id
		str += "\n"
		str += "url: " + url
		str += "\n"
		str += "width: " + String(width)
		str += "\n"
		str += "height: " + String(height)
		str += "\n"
		return str
	}

//	enum CodingKeys: String, CodingKey {
//		case breeds = "breeds"
//		case id = "id"
//		case url = "url"
//		case width = "width"
//		case height = "height"
//	}
}



struct CatInfo2: Codable, Printable {
	let breeds: [Breeds]
	let id: String?
	let url: String
	let height: Int

}

struct Breeds: Codable, Printable {
	let weight: Weight?
	let id: String?
	let name: String?
	let cfa_url: String?
	let vetstreet_url: String?
	let vcahospitals_url: String?
	let temperament: String?
	let origin: String?
	let country_codes: String?
	let country_code: String?
	let description: String?
	let life_span: String?
	let indoor: Int?
	let lap: Int?
	let adaptability: Int?
	let affection_level: Int?
	let child_friendly: Int?
	let cat_friendly: Int?
	let dog_friendly: Int?
	let energy_level: Int?
	let grooming: Int?
	let health_issues: Int?
	let intelligence: Int?
	let shedding_level: Int?
	let social_needs: Int?
	let stranger_friendly: Int?
	let vocalisation: Int?
	let bidability: Int?
	let experimental: Int?
	let hairless: Int?
	let natural: Int?
	let rare: Int?
	let rex: Int?
	let suppressed_tail: Int?
	let short_legs: Int?
	let wikipedia_url: String?
	let hypoallergenic: Int?
	let reference_image_id: String?


}

struct Weight: Codable, Printable {
	let imperial: String?
	let metric: String?
}

protocol Printable {
	func textValue() -> String
}

extension Printable {
	func textValue() -> String {
		var str = ""
		let mirror = Mirror(reflecting: self)
		for child in mirror.children {
			guard let label = child.label else { continue }
			let prefix = "Optional"
			var value = "\(child.value)"
			if value.hasPrefix(prefix) { value = String(value.dropFirst(prefix.count)) }
			str += label
			str += ": "
			str += value
			str += "\n"
		}
		return str
	}
}
