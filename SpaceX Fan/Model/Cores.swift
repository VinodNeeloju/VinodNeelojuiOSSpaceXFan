/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Cores : Codable {
	let core : String?
	let flight : String?
	let gridfins : String?
	let legs : String?
	let reused : String?
	let landing_attempt : String?
	let landing_success : String?
	let landing_type : String?
	let landpad : String?

	enum CodingKeys: String, CodingKey {

		case core = "core"
		case flight = "flight"
		case gridfins = "gridfins"
		case legs = "legs"
		case reused = "reused"
		case landing_attempt = "landing_attempt"
		case landing_success = "landing_success"
		case landing_type = "landing_type"
		case landpad = "landpad"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		core = try? values.decodeIfPresent(String.self, forKey: .core)
		flight = try? values.decodeIfPresent(String.self, forKey: .flight)
		gridfins = try? values.decodeIfPresent(String.self, forKey: .gridfins)
		legs = try? values.decodeIfPresent(String.self, forKey: .legs)
		reused = try? values.decodeIfPresent(String.self, forKey: .reused)
		landing_attempt = try? values.decodeIfPresent(String.self, forKey: .landing_attempt)
		landing_success = try? values.decodeIfPresent(String.self, forKey: .landing_success)
		landing_type = try? values.decodeIfPresent(String.self, forKey: .landing_type)
		landpad = try? values.decodeIfPresent(String.self, forKey: .landpad)
	}

}
