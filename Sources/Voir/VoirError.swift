import Foundation

enum VoirError: Error {
    static func missing<V, I>(protocol input: I.Type, for viewModel: V.Type) -> String {
        "\"\(viewModel)\" class must conform to \"\(input)\" protocol"
    }
}
