# elmenus
![](menus.png) <br />
<br />
This demo for iOS developer vacancy in elmenus.

### Used Architecture and patterns

- Clean Architecture <br/>
- MVVM + XCoordinator <br/>
- Coordinator <br/>
- Repository <br/>
- Factory

### Dependency Graph

The App originally consists of 4 tiers: <br />

**Presentation -** Responsible for representing data on screen and handle presentation logic, MVVM design pattern used in this layer. <br />
**Domain -** Responsible for handling App business UseCases. <br />
**Persistent -** Responsible for data saving and retrieving from/to data stores,and this is where repository pattern used wich contain both local and remote data sources. <br />
**Coordinator -** Its responsibility is to build modules with it's dependancies, and handling navigation beween them. <br/>

Every inner layer doesn't know anything about the outer layer. <br />

**(Protocols)** used everywhere to establish a pipeline from inner layers to outer layers, used for encapsulation and increse substitutability and this where protocol orientd comes in.

## Task Features
- Horizontal collection view with infint scrolling based on pagination.<br/>
- fetching data from remote server <br/>
- caching API response using Core Data <br/>
- stretching Header <br/>


### Pods

RxSwift <br />
RxCocoa  <br />
Alamofire  <br />
Kingfisher  <br />
XCoordinator  <br />
SwiftMessages  <br />
RxCoreData  <br />


### Remote Data Source

News API https://newsapi.org/docs/get-started
