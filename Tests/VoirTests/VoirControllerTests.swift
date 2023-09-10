import XCTest
@testable import Voir

final class VoirControllerTests: XCTestCase {

    // Test the initialization and setup of VoirController
    func testVoirControllerInitialization() throws {
        let (sut, doubles) = makeSut()

        sut.loadView()

        XCTAssertTrue(doubles.viewModel.outputSet)
        XCTAssertTrue(doubles.component.inputSet)
        XCTAssertTrue(doubles.component.layoutViewsCalled)
        XCTAssertTrue(doubles.component.bindViewsCalled)
    }

    // Test the lifecycle stage updates and observer notifications
    func testLifecycleStageUpdates() {
        let (sut, _) = makeSut()

        let mockObserver = MockLifecycleObserver()
        sut.addObserver(mockObserver)

        // Simulate different lifecycle stages
        sut.loadView()
        sut.viewDidLoad()
        sut.viewWillAppear(false)
        sut.viewDidAppear(false)
        sut.viewWillDisappear(false)
        sut.viewWillTransition(to: .zero, with: MockUIViewControllerTransitionCoordinator())
        sut.traitCollectionDidChange(nil)
        sut.didBecomeActive()
        sut.willEnterForeground()
        sut.willBecomeInactive()
        sut.viewDidDisappear(false)
        XCTAssertEqual(mockObserver.notifiedStages.count, 10)
        XCTAssertEqual(sut.observers.count, .zero)
    }

    func testComponentReceiveLifecycleStageUpdates() {
        let (sut, doubles) = makeSut()
        sut.loadView()
        sut.viewDidLoad()
        sut.viewWillAppear(false)
        sut.viewDidAppear(false)
        sut.viewWillTransition(to: .zero, with: MockUIViewControllerTransitionCoordinator())
        sut.traitCollectionDidChange(nil)
        sut.didBecomeActive()
        sut.willEnterForeground()
        sut.willBecomeInactive()
        sut.viewWillDisappear(false)
        sut.viewDidDisappear(false)

        XCTAssertEqual(doubles.component.notifiedStages.count, 10)
    }

    func testViewModelReceiveLifecycleStageUpdates() {
        let (sut, doubles) = makeSut()
        sut.loadView()
        sut.viewDidLoad()
        sut.viewWillAppear(false)
        sut.viewDidAppear(false)
        sut.viewWillTransition(to: .zero, with: MockUIViewControllerTransitionCoordinator())
        sut.traitCollectionDidChange(nil)
        sut.didBecomeActive()
        sut.willEnterForeground()
        sut.willBecomeInactive()
        sut.viewWillDisappear(false)
        sut.viewDidDisappear(false)

        XCTAssertEqual(doubles.viewModel.notifiedStages.count, 10)
    }

    func testComponentReceiveOutputFromViewModel() {
        let (sut, doubles) = makeSut()
        sut.loadView()
        
        let data = MockVoirComponent.DTO(value: 1)
        doubles.viewModel.output?.updateView(with: data)

        XCTAssertTrue(doubles.component.updateViewCalled)
    }

    func testComponentWithoutOutputConformance() {
        let viewModel = MockVoirModel()
        let sut = VoirController(MockVoirComponent_NoOutput.self, viewModel)

        let expectedMessage = """
        "MockVoirComponent_NoOutput" class must conform to "MockVoirModelOutput" protocol
        """

        expectFatalError(with: expectedMessage) {
            sut.loadView()
        }
    }

    func testViewModelWithoutInputConformance() {
        let viewModel = MockVoirModel_NoInput()
        let sut = VoirController(MockVoirComponent.self, viewModel)

        let expectedMessage = """
        "MockVoirModel_NoInput" class must conform to "MockVoirComponentInput" protocol
        """

        expectFatalError(with: expectedMessage) {
            sut.loadView()
        }
    }
}

// MARK: - SUT
private extension VoirControllerTests {
    typealias SutAndDoubles = (sut: VoirController<MockVoirComponent, MockVoirModel>, doubles: Doubles)

    struct Doubles {
        let component: MockVoirComponent
        let viewModel: MockVoirModel
    }

    func makeSut() -> SutAndDoubles {
        let viewModel = MockVoirModel()
        let controller = VoirController(MockVoirComponent.self, viewModel)
        let doubles = Doubles(component: controller.component, viewModel: viewModel)

        // Test for Memory Leaks
        addTeardownBlock { [weak controller] in
            XCTAssertNil(controller)
        }

        return (controller, doubles)
    }
}
