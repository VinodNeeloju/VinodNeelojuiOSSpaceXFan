/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Links : Codable {
	let patch : Patch?
	let reddit : Reddit?
	let flickr : Flickr?
	let presskit : String?
	let webcast : String?
	let youtube_id : String?
	let article : String?
	let wikipedia : String?

	enum CodingKeys: String, CodingKey {

		case patch = "patch"
		case reddit = "reddit"
		case flickr = "flickr"
		case presskit = "presskit"
		case webcast = "webcast"
		case youtube_id = "youtube_id"
		case article = "article"
		case wikipedia = "wikipedia"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		patch = try? values.decodeIfPresent(Patch.self, forKey: .patch)
		reddit = try? values.decodeIfPresent(Reddit.self, forKey: .reddit)
		flickr = try? values.decodeIfPresent(Flickr.self, forKey: .flickr)
		presskit = try? values.decodeIfPresent(String.self, forKey: .presskit)
		webcast = try? values.decodeIfPresent(String.self, forKey: .webcast)
		youtube_id = try? values.decodeIfPresent(String.self, forKey: .youtube_id)
		article = try? values.decodeIfPresent(String.self, forKey: .article)
		wikipedia = try? values.decodeIfPresent(String.self, forKey: .wikipedia)
	}

}
