<img align="right" src="/Support/VoirDemo/VoirDemo/Application/Resources/Assets.xcassets/voir.imageset/voir-image-transparent.png" width=30%>

# Voir

**Voir** is a tiny Swift framework designed to offer a fully functional and easy-to-use MVVM architecture for iOS app development, tailored for the braves who are still relying on UIKit.

The name **“Voir”** originates from the French word meaning **“to see”**, reflecting its objective of enhancing the visibility and clarity of your app's architecture.

This project was initiated to support a presentation at a conference that centers around delivering insightful topics to the tech community. The central theme of my talk is:

```swift
Elegant Development: poetry and beauty in Swift code.
```
<br/>
<p align="left">

| Pronunciation **/vwaʁ/** | Purpose |
|-|-|
| <img src="https://github.com/arthurdapaz/Voir/assets/2267843/cc10b766-788b-41d5-8c05-1d8d7ef45a89"> | Modern iOS app development requires a robust architecture that can handle complexity, maintainability, and separation of concerns. **Voir** aims to simplify this process by offering a clear and structured way to implement the MVVM (Model-View-ViewModel) architecture. MVVM is a popular architectural pattern that helps developers organize their codebase, improve testability, and enhance collaboration between team members. |
| Listen Voir 👆 | [<img align="right" src="https://github.com/arthurdapaz/Voir/actions/workflows/swift.yml/badge.svg">](https://github.com/arthurdapaz/Voir/actions/workflows/swift.yml) |

</p>

## Features

- **MVVM Architecture**: Voir provides a solid foundation for implementing the MVVM architecture in your iOS apps. It separates concerns by dividing the application logic into three main components: Model, View, and ViewModel.

- **Reusable Components**: The package introduces reusable components such as `VoirComponent` and `VoirModel`, making it easier to structure your app's UI and business logic.

- **Lifecycle Observations**: Voir provides built-in lifecycle observation mechanism that automatically notify its components. This feature aids in efficiently managing resource allocation and deallocation. This aspect of Voir almost eliminates the need for touching a UIViewController again, as the `VoirController` efficiently relays all of its lifecycle events to both `VoirComponent` and `VoirModel`.

- **Builder Patterns**: The framework includes builder patterns (`VoirBuilder` and `ConstraintsBuilder`) that simplify the process of constructing complex UI hierarchies and defining layout constraints. Together, these patterns provide a beautiful domain-specific language (DSL) that not only enhances your code's aesthetics but also makes it completely understandable and easy to maintain when designing, positioning, and configuring UI elements.

- **View Controller Helper**: With the `viewController` property extension on `UIView`, you can easily find the parent UIViewController of any view, aiding in navigation and communication within your app.

## Usage

1. To integrate Voir into your project, simply include the framework as a Swift package.
2. There is also a `.xctemplate` to easily create a Voir MVVM Scene. Check the recording below 👇 

https://github.com/arthurdapaz/Voir/assets/2267843/d524ce42-8847-43cf-b852-584879d11151

## Template Installer

*TemplateInstaller* is a small Swift command-line interface tool whose sole purpose is to copy the `Support/Voir Scene.xctemplate` to the necessary destination, enabling the template to appear in Xcode's `File > New` selection window.

**1)** On your terminal, inside the cloned project folder, just run:

```bash
swift run
```

**or 2)** Prefer the manual labor?

```bash
XCPATH="~/Library/Developer/Xcode/Templates/Project Templates/iOS/Application/"
mkdir -p "$XCPATH"
cp "Support/Voir Scene.xctemplate" "$XCPATH"
```

For more detailed usage instructions and examples, refer to the `DemoApp` inside `Support/` folder in the repository.

## DemoApp

Checkout **DemoApp.xcproject** at `Support/VoirDemo` folder. It has a small demonstration on how you can take advantage of every feature Voir can offer.

## Contributing

Contributions to Voir are welcome! If you find a bug, want to request a feature, or would like to improve the code, please submit an issue or pull request.

## License

Voir is unlicensed. You are free to use and modify. See LICENSE for more details.

Voir is currently developed and maintained by [Arthur da Paz](https://github.com/arthurdapaz).
