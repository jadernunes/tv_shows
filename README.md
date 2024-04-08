# TV Shows

## Description
This project will show a list of series where you can also search for a specific one.

## Topics
* [Architecture](#architecture)
* [Concepts covered](#conceptscovered)
* [In this version](#inthisversion)
* [Future items](#futureitems)
* [Dependencies](#dependencies)
* [Requirements](#requirements)

## Architecture
For this application we used **MVVM-C** where C stands for Coordinator to manage all the presentations for each flow.
Using this pattern also allow us to manage all the business logic inside the ViewModels, given a good point when we're looking at an application with Scalability, Readability and Maintainability.
Following the same concept we created a components that could be used everywhere.
* MVVM-C(Coordinator).
* asyn & await.
* Combine.
* SwiftUI.
* Cache for images.

## Concepts covered
* SOLID.
* Inheritance.
* Encapsulation.
* Maintainability.
* Scalability.
* Readability.
* Testability.
* Components.

## In this version

#### Screens
* Spalsh screen.
* Series list.
* Serie detail.
* Search serie.
* Episode list.
* Episode detail.

#### Components
* Error.
* Empty.
* Loader.

#### Other things
* App icon.
* Unit tests.
* Internationalization(*English only*).

## Future items
* Create custom frameworks/modules for each component to allow to grow scalable in a different teams
* UI tests, tesing screens and the elements in itself.
* Support both Dark and Light mode.
* Add Crashlytics to traking all issues.

## Dependencies
* [Alamofire](https://github.com/Alamofire/Alamofire) 5.8.1

## Requirements
* iOS 16.0+.
* Xcode 15.2.
* Swift 5.0.

## Screenshots
------------

| App icon | Splashscreen | List series |
| ------------- | ------------- | ------------- |
| ![iPhone1](/screenshots/image1.png?raw=true) | ![iPhone2](/screenshots/image2.png?raw=true) | ![iPhone3](/screenshots/image3.png?raw=true) |

| Search results | Serie detail | Episode detail |
| ------------- | ------------- | ------------- | 
| ![iPhone4](/screenshots/image4.png?raw=true) | ![iPhone5](/screenshots/image5.png?raw=true) | ![iPhone6](/screenshots/image6.png?raw=true) |

| Error state | Empty state | Loaders |
| ------------- | ------------- | ------------- |
| ![iPhone7](/screenshots/image7.png?raw=true) | ![iPhone8](/screenshots/image8.png?raw=true) | ![iPhone9](/screenshots/image9.png?raw=true) |
