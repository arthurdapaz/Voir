import UIKit
import VoirBuilder

open class VoirController<View: VoirComponent, ViewModel: VoirModel>: UIViewController {

    public let component = View()
    public let viewModel: ViewModel

    public init(_ component: View.Type, _ viewModel: ViewModel) {
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
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact {
            view.orientation = .portrait
        } else {
            view.orientation = .landscape
        }
        notifyObservers(.viewDidLoad(self))
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notifyObservers(.viewWillAppear(self, animated))
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startEventsObservation()
        notifyObservers(.viewDidAppear(self, animated))
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notifyObservers(.viewWillDisappear(self, animated))
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifyObservers(.viewDidDisappear(self, animated))
        stopObservations()
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        notifyObservers(.viewWillTransition(self, size, coordinator))
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        notifyObservers(.traitCollectionDidChange(self, previousTraitCollection))
    }

    // MARK: - Events Observations
    @objc
    func deviceOrientationDidChange() {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            view.orientation = .portrait
        case .landscapeLeft, .landscapeRight:
            view.orientation = .landscape
        default:
            break
        }
    }

    @objc
    func didBecomeActive() { notifyObservers(.didBecomeActive(self)) }

    @objc
    func willEnterForeground() { notifyObservers(.willEnterForeground(self)) }

    @objc
    func willBecomeInactive() { notifyObservers(.willBecomeInactive(self)) }
}

private extension VoirController {
    func startEventsObservation() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willBecomeInactive), name: UIApplication.willResignActiveNotification, object: nil)
    }

    func stopObservations() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
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
