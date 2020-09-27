import Foundation

struct SampleExtension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

protocol SampleExtensionCompatible {
    associatedtype Compatible
    static var sample: Compatible.Type { get }
    var sample: Compatible { get }
}

extension SampleExtensionCompatible {
    static var sample: SampleExtension<Self>.Type {
        return SampleExtension<Self>.self
    }

    var sample: SampleExtension<Self> {
        return SampleExtension(self)
    }
}

extension NSObject: SampleExtensionCompatible {}
