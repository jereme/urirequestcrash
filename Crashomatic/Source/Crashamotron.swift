//
//  Crashamotron.swift
//  Crashomatic
//
//  Created by Jereme Claussen on 6/20/17.
//  Copyright © 2017 Jereme Claussen. All rights reserved.
//

import Alamofire
import Foundation

struct Crashamotron {
    static let sessionManager = SessionManager()

    static func testAFCrash() {
        let url = "https://httpbin.org/headers"

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "X-Taco": "party",
            "X-Hamburger": "party",
            "X-Hotdog": "party",
            "X-Cupcake": "party",
            "X-Taco2": "party",
            "X-Taco3": "party",
            "X-Taco4": "party",
            "X-Taco5": "party",
            "X-Taco6": "party",
        ]

        let validStatusCodes = [200]

        let afRequest = sessionManager.request(url, headers: headers)

        afRequest.validate(statusCode: validStatusCodes).validateContentTypeMatchesAcceptHeader()

        afRequest.responseJSON { response in
            guard let request = afRequest.request else { return }

            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
            tauntRequest(request)
        }
    }

    static func testCrash() {
        guard let url = URL(string: "http://www.google.com") else { return }

        var request = URLRequest(url: url)

        for i in 1...10  {
            request.setValue("\(i)", forHTTPHeaderField: "\(i)")
        }


        URLSession.shared.dataTask(with: request) { data, response, error in


        }
        _ = request.httpBody

        DispatchQueue.global(qos: .utility).async {
            let requestCopy = request
            _ = requestCopy.allHTTPHeaderFields
        }

        DispatchQueue.global(qos: .utility).async {
            let requestCopy = request
            _ = requestCopy.allHTTPHeaderFields
        }
    }

    static func tauntRequest(_ request: URLRequest) {
        DispatchQueue.global(qos: .utility).async {
            let requestCopy = request
            _ = requestCopy.allHTTPHeaderFields
        }
    }
}

extension DataRequest {
    @discardableResult
    func validateContentTypeMatchesAcceptHeader() -> Self {
        return validate(contentType: acceptableContentTypes)
    }

    private var acceptableContentTypes: [String] {
        if let accept = request?.value(forHTTPHeaderField: "Accept") {
            return accept.components(separatedBy: ",")
        }

        return ["*/*"]
    }
}
