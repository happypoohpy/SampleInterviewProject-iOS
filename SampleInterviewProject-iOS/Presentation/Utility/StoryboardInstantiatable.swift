import UIKit

protocol StoryboardInstantiatable: class {
    associatedtype InitialViewController: UIViewController = Self
    static var storyboardName: String { get }
    static var initialViewController: InitialViewController { get }
}

extension StoryboardInstantiatable where Self: UIViewController {
    static var initialViewController: InitialViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? InitialViewController else {
            fatalError("Initial ViewController is not \(Self.self)")
        }
        return viewController
    }
}
