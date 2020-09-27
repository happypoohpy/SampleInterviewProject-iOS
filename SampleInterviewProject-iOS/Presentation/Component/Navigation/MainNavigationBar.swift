import UIKit

final class MainNavigationBar: UINavigationBar {
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isTranslucent = false
        barTintColor = .white
        tintColor = UIColor.sample.white
        
        if let font = UIFont.sample.openSansBold(size: 18.0) {
            titleTextAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.sample.white
            ]
        }
    }
}
