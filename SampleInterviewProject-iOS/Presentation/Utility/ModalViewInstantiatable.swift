import UIKit

@objc protocol ModalViewInstantiatable: class {}

extension ModalViewInstantiatable where Self: StoryboardInstantiatable, Self.InitialViewController == Self {
    
    static func instantiateModalViewController(setupNavigationItem: Bool = false, setup: ((UIViewController) -> Void)? = nil) -> UINavigationController {
        let viewController: UIViewController = {
            let viewController = Self.initialViewController
            if setupNavigationItem {
                viewController.setupNavigationItem()
            }
            setup?(viewController)
            return viewController
        }()
        
        let navigationController = UINavigationController(navigationBarClass: MainNavigationBar.self, toolbarClass: nil)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}

extension StoryboardInstantiatable where Self: UIViewController, Self.InitialViewController == Self {
    fileprivate func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "ico_close"),
            style: .plain,
            target: self,
            action: #selector(handleModalViewClose(sender:))
        )
    }
}
