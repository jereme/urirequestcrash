# urirequestcrash
An example of how URLRequest can cause a crash when accessed from multiple threads

# Description

A `URLRequest` lazily parses out the various components of the request such as headers and body. Some aspects of this parser appear to not be thread safe.  To produce a crash, you can simply create a new request object, then in multiple async operations, attempt to access the headers of the request.  Eventually, with not too much effort, you can crash.
