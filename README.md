<img align="right" src="/Support/VoirDemo/VoirDemo/Application/Resources/Assets.xcassets/voir.imageset/voir-image-transparent.png" width=30%>

# Voir

Voir is a Swift framework designed to provide a fully functional and easy-to-use MVVM architecture for iOS app development for the braves still relying on UIKit.

The name **“Voir”** comes from the French word meaning **“to see”** reflecting its goal of enhancing the visibility and clarity of your app's architecture.

This project was created to support a presentation at a conference focused on delivering useful topics to the tech community. The theme of my talk is:

```swift
Elegant Development: poetry and beauty in Swift code.
```
<br/>
<p align="left">

| Pronunciation **/vwaʁ/** | Purpose |
|-|-|
| <img src="https://github.com/arthurdapaz/Voir/assets/2267843/cc10b766-788b-41d5-8c05-1d8d7ef45a89"> | Modern iOS app development requires a robust architecture that can handle complexity, maintainability, and separation of concerns. **Voir** aims to simplify this process by offering a clear and structured way to implement the MVVM (Model-View-ViewModel) architecture. MVVM is a popular architectural pattern that helps developers organize their codebase, improve testability, and enhance collaboration between team members. |
| Listen Voir 👆 |  |

</p>

## Features

- **MVVM Architecture**: Voir provides a solid foundation for implementing the MVVM architecture in your iOS apps. It separates concerns by dividing the application logic into three main components: Model, View, and ViewModel.

- **Reusable Components**: The package introduces reusable components such as `VoirComponent` and `VoirModel`, making it easier to structure your app's UI and business logic.

- **Lifecycle Observations**: Voir provides built-in lifecycle observation mechanism that automatically notify its components. This feature aids in efficiently managing resource allocation and deallocation. This aspect of Voir almost eliminates the need for touching a UIViewController again, as the `VoirController` efficiently relays all of its lifecycle events to both `VoirComponent` and `VoirModel`.

- **Builder Patterns**: The framework includes builder patterns (`VoirBuilder` and `ConstraintsBuilder`) that simplify the process of constructing complex UI hierarchies and defining layout constraints.

- **View Controller Helper**: With the `viewController` property extension on `UIView`, you can easily find the parent UIViewController of any view, aiding in navigation and communication within your app.

## Usage

1. To integrate Voir into your project, simply include the framework as a Swift package.
2. There is also a `.xctemplate` to easily create a Voir MVVM Scene. Check the recording below 👇 

https://github.com/arthurdapaz/Voir/assets/2267843/d524ce42-8847-43cf-b852-584879d11151

For more detailed usage instructions and examples, refer to the `DemoApp` inside `Support/` folder in the repository.

## Contributing

Contributions to Voir are welcome! If you find a bug, want to request a feature, or would like to improve the code, please submit an issue or pull request.

## License

Voir is free of license. You are free to use and modify. See LICENSE for more details.

Voir is currently developed and maintained by [Arthur da Paz](https://github.com/arthurdapaz).
