import Foundation

final class SimulatorObtainer {
    struct Devices: Codable {
        struct Device: Codable {
            let udid: String
            let isAvailable: Bool
            let name: String
        }
        let devices: [String: [Device]]
    }

    private func shell(run command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()

        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.arguments = ["-c", command]
        task.standardOutput = pipe
        task.standardError = pipe

        try task.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    private func substring(of input: String, thatMatches regexp: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: regexp) else { return "" }
        let range = NSRange(location: 0, length: input.utf8.count)

        guard let result = regex.firstMatch(in: input, options: [], range: range),
              let swiftRange = Range(result.range, in: input)
        else { return "" }

        return String(input[swiftRange])
    }

    func obtainActiveSimulator() throws -> String {
        let devices = try shell(run: "xcrun simctl list devices available -j")
        let jsonData = devices.data(using: .utf8)!

        let deviceInfo = try JSONDecoder().decode(Devices.self, from: jsonData)

        let info = deviceInfo
            .devices
            .first { key, value in
                key.contains("iOS") && !value.isEmpty
            }
            .flatMap { runtime, devices -> (key: String, device: Devices.Device)? in
                guard let device = devices.first else { return nil }
                return (runtime, device)
            }

        guard let info else { fatalError("No iOS device available") }

        let version = substring(of: info.key, thatMatches: "(\\d+-?\\d+)").replacingOccurrences(of: "-", with: ".")

        let platform = "platform=iOS Simulator"

        let deviceName = "name=\(info.device.name)"

        let osVersion = "OS=\(version)"

        return [platform, deviceName, osVersion].joined(separator: ",")
    }
}

let obtainer = SimulatorObtainer()
let destination = try obtainer.obtainActiveSimulator()
print(destination)
