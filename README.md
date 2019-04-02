# Viper Kit

App divided to 4 layers: **Launch Layer**, **Core Layer**, **Model Layer** and **Presentation Layer**.

Main app function and App Assembly declared and implemented in **Launch Layer**.

Storyboard, System Infrastructure and Tools Assemblies, Mapping and Networking methods are declared and implemented in **Core Layer**.

Entities, Services, Repositories, Service- and Repository Assemblies declared and implemented in **Model Layer**.

Modules, CustomViews, Segues and etc. declared and implemented in **Presentation Layer**.

[Example App](https://github.com/galuzokb/ViperKitExample) written using ViperKit

# Documentation  
* [Usage](#Usage)  
   * [Launch Layer](#launch-layer)
   * [Core Layer](#core-layer)
   * [Presentation Layer](#presentation-layer)
       * [Generamba installation and setup](#generamba-installation-and-setup)
       * [Module configuration](#module-configuration)
   * [Model Layer](#model-layer)
   * [.gitignore](#gitignore)

# Installation

pod 'ViperKit', :git => 'https://github.com/galuzokb/ViperKit'

# Usage

## Launch Layer

Create new swift file called "main.swift"

Create class inherited from Application class and override factory property.

``` swift
import Foundation
import ViperKit

class ViperKitExampleApplication: Application {

    override class var factory: AssembliesFactory {
        return ViperKitExampleAssembliesFactory()
    }

}
```

Application entry point

```swift
UIApplicationMain(

    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(
        to: UnsafeMutablePointer<Int8>.self,
        capacity: Int(CommandLine.argc)
    ),
    NSStringFromClass(ViperKitExampleApplication.self),
    NSStringFromClass(AppDelegate.self)

)
```

Then remove @UIApplicationMain in AppDelegate

Create new file called AppDelegateAssembly.

```swift
import Foundation
import ViperKit

class AppDelegatesAssembly: BaseLaunchAssembly {

    override init(withCollaborator collaborator: RootLaunchAssembly) {
        super.init(withCollaborator: collaborator)
        container.register { AppDelegate() }
    }

}
```


There we can resolve AppDelegate's properties. For example, if you have Notification Service for handling Remote Notifications and you have declared instance of it in AppDelegate:

```swift
container.register { AppDelegate() }.resolvingProperties { (container, delegate) in
     delegate.notificationService = try container.resolve()
}
```

Create {ProjectName}AssembliesFactory file

```swift
import Foundation
import ViperKit

class ViperKitExampleAssembliesFactory: AssembliesFactory {

    override func registerLaunchLayer(root: RootLaunchAssembly) {
        container.register(.eagerSingleton) { AppDelegatesAssembly(withCollaborator: $0) }
    }

    override func registerCoreLayer(root: RootCoreAssembly) {
        container.register(.eagerSingleton) { ToolsAssembly(withRoot: $0) }
        container.register(.eagerSingleton) { SystemAssembly(withRoot: $0) }
        container.register(.eagerSingleton) { StoryboardAssembly(withRoot: $0, system: $1) }
    }

    override func registerServicesLayer(root: RootServicesAssembly) {
        container.register(.eagerSingleton) { RepositoriesAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { ServicesAssembly(withCollaborator: $0) }
    }

    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { {ModuleName}ModuleAssembly(withCollaborator: $0) }
    }

}

```

This factory is created on app launch. In this factory launch, core, model and presentation layers are registered in DI container.

## Core Layer

To register storyboards used in project create StoryboardAssembly

```swift
import ViperKit

class StoryboardAssembly: BaseCoreAssembly {

    var {moduleName}Storyboard: UIStoryboard {
        return resolve(tag: "{moduleName}")
    }    

    init(withRoot root: RootCoreAssembly, system: SystemAssembly) {

        super.init(withRoot: root)
        container.register(.singleton, tag: "{moduleName}") { UIStoryboard(name: "{ModuleName}", bundle: system.bundle) }
        bootstrap()
    }

}
```

## Presentation Layer

To create module I suggest to use code generator [Generamba](https://github.com/strongself/Generamba)

### Generamba installation and setup

To install Generamba:
```
gem install generamba
```

Run in project directory

```
generamba setup
```

That will create Rambafile. Example:

```
### Headers settings
company: galuzokb@gmail.com

### Xcode project settings
project_name: ViperKitExample
xcodeproj_path: ViperKitExample.xcodeproj

### Code generation settings section
# The main project target name
project_target: ViperKitExample

# The file path for new modules
project_file_path: /ViperKitExample/PresentationLayer/UserStories/

### Dependencies settings section
podfile_path: Podfile

catalogs:
- 'https://github.com/galuzokb/ViperKitModuleTemplate.git'

### Templates
templates:
#- {name: galuzokb-viper-template, git: 'https://github.com/igrekde/remote_template'}
- {name: galuzokb-viper-template}
```

To install templates run.
```
generamba template install
```
This command will clone template from git repository into /Templates folder in you project folder.

To generate new module files with [MODULE_NAME] in folder /YourProjectFolder/PresentationLayer/UserStories/ run:
```
generamba gen [MODULE_NAME] galuzokb-viper-template
```

### Module configuration

Create Storyboard file in View folder and name it with [MODULE_NAME].

Next step is to register new Module Assembly in AppAssembilesFactory. To do that you need to add:

```swift
container.register(.eagerSingleton) { {MODULE_NAME}ModuleAssembly(withCollaborator: $0) }
```
registerPresentationLayer(root: RootViperAssembly) method in {ProjectName}AssembliesFactory

Set attribute dipTag with value nil in user defined runtime attributes for new ViewController.

## Model Layer

Register services and repositories.
ServicesAssembly with registered TestService (implementation of TestService protocol) as example

```swift
import ViperKit

class ServicesAssembly: BaseServiceAssembly {

    override init(withCollaborator collaborator: RootServicesAssembly) {
        super.init(withCollaborator: collaborator)
        container.register(.singleton) { TestService(repository: $0) as TestServiceType }
        bootstrap()
    }

}
```

## .gitignore

You may need to include some folders in .gitignore file.

```
Pods/
Templates/
xcuserdata/
*.xcworkspace/
.DS_Store
output/
derivedData/
```
