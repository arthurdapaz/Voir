import Foundation
@testable import Voir

final class MockLifecycleObserver: LifecycleObserver {
    
    private(set) var notifiedStages = [String]()
    func lifecycleUpdate(_ cycle: Lifecycle) {
        notifiedStages.append(String(describing: cycle))
    }
}
