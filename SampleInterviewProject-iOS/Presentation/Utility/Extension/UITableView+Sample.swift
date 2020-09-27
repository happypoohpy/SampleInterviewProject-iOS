import UIKit

extension SampleExtension where Base: UITableView {

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T
        where T: ReusableDequeueable {
            guard let cell = base.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
                fatalError("Can not dequeue \(T.self)")
            }

            return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T
        where T: ReusableDequeueable {
            guard let view = base.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
                fatalError("Can not dequeue \(T.self)")
            }

            return view
    }

    func deselectAllRows(animated: Bool) {
        base.indexPathsForSelectedRows?.forEach {
            base.deselectRow(at: $0, animated: animated)
        }
    }
}
