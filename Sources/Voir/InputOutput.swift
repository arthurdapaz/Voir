public protocol InputSender: AnyObject {
    associatedtype Input
    var input: Input? { get set }
}

public protocol OutputSender: AnyObject {
    associatedtype Output
    var output: Output? { get set }
}
