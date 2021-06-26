/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct RocketResponse : Codable {
	let fairings : Fairings?
	let links : Links?
	let static_fire_date_utc : String?
	let static_fire_date_unix : String?
	let tbd : Bool?
	let net : Bool?
	let window : String?
	let rocket : String?
	let success : Bool?
	let details : String?
	let crew : [String]?
	let ships : [String]?
	let capsules : [String]?
	let payloads : [String]?
	let launchpad : String?
	let auto_update : Bool?
	let launch_library_id : String?
	let failures : [Failures]?
	let flight_number : Int?
	let name : String?
	let date_utc : String?
	let date_unix : Int?
	let date_local : String?
	let date_precision : String?
	let upcoming : Bool?
	let cores : [Cores]?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case fairings = "fairings"
		case links = "links"
		case static_fire_date_utc = "static_fire_date_utc"
		case static_fire_date_unix = "static_fire_date_unix"
		case tbd = "tbd"
		case net = "net"
		case window = "window"
		case rocket = "rocket"
		case success = "success"
		case details = "details"
		case crew = "crew"
		case ships = "ships"
		case capsules = "capsules"
		case payloads = "payloads"
		case launchpad = "launchpad"
		case auto_update = "auto_update"
		case launch_library_id = "launch_library_id"
		case failures = "failures"
		case flight_number = "flight_number"
		case name = "name"
		case date_utc = "date_utc"
		case date_unix = "date_unix"
		case date_local = "date_local"
		case date_precision = "date_precision"
		case upcoming = "upcoming"
		case cores = "cores"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fairings = try? values.decodeIfPresent(Fairings.self, forKey: .fairings)
		links = try? values.decodeIfPresent(Links.self, forKey: .links)
		static_fire_date_utc = try? values.decodeIfPresent(String.self, forKey: .static_fire_date_utc)
		static_fire_date_unix = try? values.decodeIfPresent(String.self, forKey: .static_fire_date_unix)
		tbd = try? values.decodeIfPresent(Bool.self, forKey: .tbd)
		net = try? values.decodeIfPresent(Bool.self, forKey: .net)
		window = try? values.decodeIfPresent(String.self, forKey: .window)
		rocket = try? values.decodeIfPresent(String.self, forKey: .rocket)
		success = try? values.decodeIfPresent(Bool.self, forKey: .success)
		details = try? values.decodeIfPresent(String.self, forKey: .details)
		crew = try? values.decodeIfPresent([String].self, forKey: .crew)
		ships = try? values.decodeIfPresent([String].self, forKey: .ships)
		capsules = try? values.decodeIfPresent([String].self, forKey: .capsules)
		payloads = try? values.decodeIfPresent([String].self, forKey: .payloads)
		launchpad = try? values.decodeIfPresent(String.self, forKey: .launchpad)
		auto_update = try? values.decodeIfPresent(Bool.self, forKey: .auto_update)
		launch_library_id = try? values.decodeIfPresent(String.self, forKey: .launch_library_id)
		failures = try? values.decodeIfPresent([Failures].self, forKey: .failures)
		flight_number = try? values.decodeIfPresent(Int.self, forKey: .flight_number)
		name = try? values.decodeIfPresent(String.self, forKey: .name)
		date_utc = try? values.decodeIfPresent(String.self, forKey: .date_utc)
		date_unix = try? values.decodeIfPresent(Int.self, forKey: .date_unix)
		date_local = try? values.decodeIfPresent(String.self, forKey: .date_local)
		date_precision = try? values.decodeIfPresent(String.self, forKey: .date_precision)
		upcoming = try? values.decodeIfPresent(Bool.self, forKey: .upcoming)
		cores = try? values.decodeIfPresent([Cores].self, forKey: .cores)
		id = try? values.decodeIfPresent(String.self, forKey: .id)
	}

}
