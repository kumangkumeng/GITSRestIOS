# GITSRest

[![CI Status](http://img.shields.io/travis/rahadian@dealservices.nl/GITSRest.svg?style=flat)](https://travis-ci.org/rahadian@dealservices.nl/GITSRest)
[![Version](https://img.shields.io/cocoapods/v/GITSRest.svg?style=flat)](http://cocoapods.org/pods/GITSRest)
[![License](https://img.shields.io/cocoapods/l/GITSRest.svg?style=flat)](http://cocoapods.org/pods/GITSRest)
[![Platform](https://img.shields.io/cocoapods/p/GITSRest.svg?style=flat)](http://cocoapods.org/pods/GITSRest)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GITSRest is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GITSRest"
```

## Usage

```swift
import GITSRest

GITSRest.runRequest(urlRequest: createRequest(), jsonValidation : { json in

    if json["status"].intValue != 200
    {
        return NSError(domain: json["message"].stringValue, code: json["status"].intValue, userInfo: nil)
    }

    return nil
}, callback: { err, json in
    
})

```

## Author

kumangxxx@gits.co.id

## License

GITSRest is available under the MIT license. See the LICENSE file for more info.
