import Foundation

enum Const {
    static let apiHost: String = {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "ApiHost") as? String else {
            fatalError("ApiHost is not set in Info.plist")
        }
        return host
    }()

    static let commonString: String = {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "CommonString") as? String else {
            fatalError("CommonString is not set in Info.plist")
        }
        return value
    }()
}
