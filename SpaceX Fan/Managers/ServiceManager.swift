//
//  ServiceManager.swift
//  SampleForecastApp
//
//  Created by iOS Dev on 21/06/21.
//

import Foundation

class ServiceManager: NSObject {
    
    ///Method types of the Api request.
    enum MethodeType : String {
        case Get = "GET"
        case Post = "POST"
        case Put = "PUT"
        case Delete = "DELETE"
    }
    
    ///Status codes of httpResponse, statuscodes are to compare whether the api request is success or failure or anyother reason codes to fail. Ex, codes are 200, 400, 404....
    /**Http resonse codes*/
    enum StatusCodes : Int {
        case Success = 200
    }
    
    ///This method is to request the server to fetch the data of the perticualar server api
    ///Used URLSession to comunicate the server
    static func request(with type : MethodeType, urlString : String, params : Dictionary<String, Any>? = nil, complation : ((_ status : Bool, _ message : String, _ responseObject : Data?) -> ())?) {
        
        guard let url = URL(string: urlString) else {
            complation?(false, "URL formation is not correct.", nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        if params != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params!, options: [])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else {
                print("error: not a valid http response")
                complation?(false, error?.localizedDescription ?? "", nil)
                return
            }
            switch httpResponse.statusCode {
            case StatusCodes.Success.rawValue:
                    complation?(true, "Success", receivedData)
            default:
                complation?(false, error?.localizedDescription ?? "", data)
                break
            }
        })

        task.resume()
        
    }
}


