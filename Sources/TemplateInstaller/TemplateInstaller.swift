import Foundation

enum Errors: Error, CustomStringConvertible {
    case templateNotFound
    case destinationNotFound

    var description: String {
        switch self {
        case .templateNotFound:
            return "Template path not found"
        case .destinationNotFound:
            return "Destination path not found. Make sure you have Xcode installed."
        }
    }
}

@main
struct TemplateInstaller {
    static func main() async throws  {
        let xctemplate = "Voir Scene.xctemplate"
        let xctemplatePath = FileManager.default.currentDirectoryPath.appending("/Support/\(xctemplate)")

        guard FileManager.default.fileExists(atPath: xctemplatePath) else {
            throw Errors.templateNotFound
        }

        let destinationPath = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("Developer/Xcode/Templates/Project Templates/iOS/Application")
            .path

        guard FileManager.default.fileExists(atPath: destinationPath) else {
            throw Errors.destinationNotFound
        }

        try? FileManager.default.removeItem(atPath: destinationPath.appending("/\(xctemplate)"))

        try FileManager.default.copyItem(atPath: xctemplatePath, toPath: destinationPath.appending("/\(xctemplate)"))

        print("Voir Template installed successfully!")
    }
}
