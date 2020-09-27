import UIKit

extension UIViewController {
    @objc func handleModalViewClose(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
