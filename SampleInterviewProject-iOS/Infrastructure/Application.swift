import Foundation

struct Application {
    static let shared = Application()

    var build: Build {
        #if DEBUG
        return .debug
        #elseif RELEASE
        return .release
        #else
        return .debug
        #endif
    }

    var bundleIdentifier: String {
        return bundle.bundleIdentifier ?? "Unknown"
    }

    var version: String {
        let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? "Unknown"
    }

    var buildNumber: String {
        let key = kCFBundleVersionKey as String
        let buildNumber = bundle.object(forInfoDictionaryKey: key) as? String
        return buildNumber ?? "Unknown"
    }

    private let bundle = Bundle.main

    private init() {
    }
}

extension Application {
    enum Build {
        case debug
        case release
    }
}
