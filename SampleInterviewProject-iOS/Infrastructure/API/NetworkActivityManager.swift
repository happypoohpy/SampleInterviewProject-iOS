import Foundation
import RxSwift

final class NetworkActivityManager {

    static let shared = NetworkActivityManager()

    // MARK: - Property

    let isActive: Observable<Bool>

    private let activityCount = Variable<Int>(0)
    private let lock = NSLock()

    // MARK: - Initializer

    private init() {
        isActive = activityCount.asObservable().map { $0 > 0 }
    }

    // MARK: - Public

    func didResume() {
        increment()
    }

    func didComplete() {
        decrement()
    }
}

extension NetworkActivityManager {
    private func increment() {
        lock.lock(); defer { lock.unlock() }
        activityCount.value += 1
    }

    private func decrement() {
        lock.lock(); defer { lock.unlock() }
        if activityCount.value > 0 {
            activityCount.value -= 1
        }
    }
}
