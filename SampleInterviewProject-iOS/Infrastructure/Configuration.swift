import Foundation

struct Configuration {
    static let shared = Configuration()

    var apiScheme: String {
        return string(forKey: "API scheme")
    }

    var apiHost: String {
        return string(forKey: "API host")
    }

    var apiBasicAuthRequired: Bool {
        return bool(forKey: "API basic auth required")
    }

    var apiBasicAuthUser: String {
        return string(forKey: "API basic auth user")
    }

    var apiBasicAuthPassword: String {
        return string(forKey: "API basic auth password")
    }
}

extension Configuration {
    private var filePath: String {
        let fileName: String
        switch Application.shared.build {
        case .debug:
            fileName = "Configuration"
        case .release:
            fileName = "Configuration"
        }

        return Bundle.main.path(forResource: fileName, ofType: "plist")!
    }

    private var info: [String: Any] {
        return (NSDictionary(contentsOfFile: filePath) as? [String: Any]) ?? [:]
    }
}

extension Configuration {
    private func string(forKey key: String) -> String {
        return info[key] as! String // swiftlint:disable:this force_cast
    }

    private func bool(forKey key: String) -> Bool {
        return info[key] as! Bool // swiftlint:disable:this force_cast
    }

    private func url(forKey key: String) -> URL {
        return URL(string: string(forKey: key))!
    }

    fileprivate func url(path: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Configuration.shared.apiScheme
        urlComponents.host = Configuration.shared.apiHost
        urlComponents.path = path
        return urlComponents.url!
    }
}
