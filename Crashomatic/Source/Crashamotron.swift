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
    static var requestNumber = 0

    static let sessionManager = SessionManager()

    static let headers: HTTPHeaders = [
        "Accept": "application/json",
        "X-Taco": "party",
        "X-Hamburger": "party",
        "X-Hotdog": "party",
        "X-Cupcake": "party",
        "X-Backyard": "party",
        "X-Hardy": "party",
        "X-Tupperware": "party",
        "X-Costume": "party"
    ]

    static let url = "https://httpbin.org/headers"

    // Crash with Alamofire

    static func testAFCrash() {
        self.requestNumber += 1

        let requestNumber = self.requestNumber

        let validStatusCodes = [200]

        let afRequest = sessionManager.request(url, headers: headers)

        // Uncomment this line to fix the crash...
        // _ = afRequest.request.httpBody

        afRequest.validate(statusCode: validStatusCodes).validateContentTypeMatchesAcceptHeader()

        if let request = afRequest.request {
            tauntRequest(request)
        }

        print("Sending request \(requestNumber)")

        afRequest.responseJSON { response in
            if let error = response.error {
                print("Error on request \(requestNumber): \(error)")
            } else {
                print("Completed request \(requestNumber)")
            }
        }
    }

    // Crash with Foundation only
    
    static func testCrash() {
        guard let url = URL(string: url) else { return }

        self.requestNumber += 1

        let requestNumber = self.requestNumber

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers

        // Uncomment this line to fix the crash...
        // _ = request.httpBody

        withUnsafePointer(to: &request) {
            print("Original request address is \($0)")
        }

        var task: URLSessionDataTask?

        task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let request = task?.originalRequest {
                tauntRequest(request)
            }

            if let error = error {
                print("Error on request \(requestNumber): \(error)")
            } else {
                print("Completed request \(requestNumber)")
            }
        }

        task?.resume()

        print("Completed request \(requestNumber)")

    }

    static func tauntRequest(_ request: URLRequest) {
        var request = request

        // ... or uncomment this line to fix the crash
        // request.setValue("Foo", forHTTPHeaderField: "Bar")

        withUnsafePointer(to: &request) {
            print("Taunted request address is \($0)")
        }

        DispatchQueue.global(qos: .utility).async {
            _ = request.allHTTPHeaderFields
        }
        DispatchQueue.global(qos: .utility).async {
            _ = request.allHTTPHeaderFields
        }
    }
}

// MARK: -

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
