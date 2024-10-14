## Data USA

The idea of this small app is to be used to retrieve a list with some USA populational data. 
The user can select if they want to see it by state or for the entire nation and if they want only the latest data or all available in the API.

### Technologies
- The app is entirely written in [_Swift_](https://www.swift.org/)
- The UI framework is [_SwiftUI_](https://developer.apple.com/documentation/SwiftUI)
- And the architecture is [_MVVM_](https://en.wikipedia.org/wiki/Model–view–viewmodel)
- There are no external dependencies
- Unit tests are created using [_XCTest_](https://developer.apple.com/documentation/xctest) framework
- The data is provided by [_Data USA_](https://datausa.io/about/api/)
- The network layer was implemented using [_async/await_](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0296-async-await.md)

### Current Scope
At this time, the app has two screens:
- The main one where the user selects the inputs to perform the request.
- The screen where they can see the requested data.

The endpoints are, essentially, the same with some query parameters that defines what will be returned.
For example: _https://datausa.io/api/data?drilldowns=**Nation**&measures=**Population**&year=**latest**_.
The **drilldowns** is the parameter used to select if we need the information regarding the Nation or State.
For this app, the **measures** parameter is always the same, Population.
Lastly, the **year** parameter is used if we want to see only the latest dataset or all of the availables - in that case, we don't send the parameter year.

### Improvements and Know Issues
- During the tests an issue was found in iPad where, after the first search, the user is not being able to do more searches.
- Add filters and sorting options so the user can customise the way that the data will be presented.
- Allow some sort of export of the data in a spreadsheet or text format.
- Provide some charts to give a more visual representation of the data.
- Add UI and Snapshot tests.
- Port the app to the other Apple Platforms such as macOS and visionOS.
