// https://github.com/Quick/Quick

import Quick
import Nimble
import GITSRest
import SwiftyJSON

class TableOfContentsSpec: QuickSpec {
    
    enum RequestMethod : String
    {
        case POST = "POST"
        case GET = "GET"
    }
    
    func createRequest(urlString : String, method : RequestMethod = .GET, headers : [String : String] = [ : ], body : Data? = nil) -> URLRequest?
    {
        
        if let url = URL(string: urlString)
        {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            request.httpBody = body
            return request
        }
        
        return nil
    }
    
    override func spec() {
        describe("these will fail") {

            it("check status of company/all api")
            {
                if let request = self.createRequest(urlString: "http://api-dev.stroomhead.com/company/74c2889b-6c4a-4ceb-97c3-cf5186e6bb6a", headers: ["usertoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMzNkYWI1YjAtZDIzNi00MzJiLWFmOGYtNTk0NTBiNzVjNjY5IiwiZXhwaXJlZF9kYXRlIjoxNTEzNzYzODI3LjMwNCwiaWF0IjoxNDgyMjI3ODI3fQ.yZZ-26I2_suTj1toIMMfOgAP5lJjtZbrnYvcx8qHZAQ"])
                {
                    debugPrint(request)
                    waitUntil(timeout: 10) { done in
                        let _ = GITSRest.runRequest(urlRequest: request, jsonValidation : { json in
                            
                            if json["status"].intValue != 200
                            {
                                return .serverFailure(code: json["status"].intValue, message: json["message"].stringValue)
                            }
                            
                            return nil
                        }, callback: { err, json in
                            var status = 0
                            
                            expect(status) == 200
                            expect(err).to(beNil())
                            done()
                        })
                    }
                } else {
                    expect(0) == 1
                }
            }
            
            
        }
    }
}
