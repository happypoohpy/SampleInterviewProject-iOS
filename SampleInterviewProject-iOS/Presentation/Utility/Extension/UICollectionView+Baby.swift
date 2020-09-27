import UIKit

extension SampleExtension where Base: UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T
        where T: ReusableDequeueable {
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Can not dequeue \(T.self)")
        }

        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ type: T.Type, of kind: String,
                                                                       for indexPath: IndexPath) -> T
        where T: ReusableDequeueable {
        guard let view = base.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: T.identifier,
                                                               for: indexPath) as? T else {
            fatalError("Can not dequeue \(T.self)")
        }

        return view
    }

    func deselectItems(animated: Bool) {
        base.indexPathsForSelectedItems?.forEach {
            base.deselectItem(at: $0, animated: animated)
        }
    }
}
