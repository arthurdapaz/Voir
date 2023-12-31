import UIKit
import VoirBuilder

open class VoirController<View: VoirComponent, ViewModel: VoirModel>: UIViewController {

    public let component: View
    public let viewModel: ViewModel

    public init(_ component: View.Type, _ viewModel: ViewModel) {
        self.component = component.init()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }

    public final override func loadView() {
        defer {
            guard let input = viewModel as? View.Input else {
                let error = VoirError.missing(protocol: View.Input.self, for: ViewModel.self)
                #if DEBUG
                triggerFatalError(error, #file, #line)
                #else
                fatalError(error)
                #endif
            }
            guard let output = component as? ViewModel.Output else {
                let error = VoirError.missing(protocol: ViewModel.Output.self, for: View.self)
                #if DEBUG
                triggerFatalError(error, #file, #line)
                #else
                fatalError(error)
                #endif
            }
            viewModel.output = output
            component.input = input
            component.layoutViews()
            component.bindViews(with: input)
            addObserver(component)
            addObserver(viewModel)
        }
        view = component
    }

    // MARK: - Lifecycle Stage Observations
    struct Weakening {
        weak var value: LifecycleObserver?
    }

    var observers = [Weakening]()

    public final func addObserver(_ observer: LifecycleObserver) {
        observers.append(Weakening(value: observer))
    }

    // MARK: - ViewController LifeCycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        notifyObservers(.viewDidLoad)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notifyObservers(.viewWillAppear(animated))
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startEventsObservation()
        notifyObservers(.viewDidAppear(animated))
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notifyObservers(.viewWillDisappear(animated))
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifyObservers(.viewDidDisappear(animated))
        stopObservations()
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        notifyObservers(.viewWillTransition(size, coordinator))
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        notifyObservers(.traitCollectionDidChange(previousTraitCollection))
    }

    // MARK: - Events Observations
    @objc
    func didBecomeActive() { notifyObservers(.didBecomeActive) }

    @objc
    func willEnterForeground() { notifyObservers(.willEnterForeground) }

    @objc
    func willBecomeInactive() { notifyObservers(.willBecomeInactive) }
}

private extension VoirController {
    func startEventsObservation() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willBecomeInactive), name: UIApplication.willResignActiveNotification, object: nil)
    }

    func stopObservations() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        observers.removeAll()
    }

    func notifyObservers(_ stageUpdate: Lifecycle) {
        observers.forEach { $0.value?.lifecycleUpdate(stageUpdate) }
    }
}

#if DEBUG
var triggerFatalError = Swift.fatalError
#endif
