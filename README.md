# EarthQuakeCollector_EBay

Use Xcode 12.7
Build for a minimum SDK target of 12.1(Due to Xcode version)
Testing target: 14.4(Just to show we can have two separate targets)
Targets: iPhone and iPad with portrait and landscape mode

Since, I did take home project in swift due to requirements. I am also sharing a small project that I was building in order to setup an architecture for reactive programming that can help us write decouple code with Unit testing ability. So please feel free to take look at that. Please feel free to let me know what do you think about it and how can I improve my skills.

Take home test link: https://github.com/KevalPatel94/EarthQuakeCollector_EBay
Driver Link: https://drive.google.com/drive/folders/1Nu2hHXUYOo5in5l_u_zFZO2Knx0AuCx9?usp=sharing
RxSwiftArchitecture practice project: https://github.com/KevalPatel94/KevalPatel94-RxSwift-MVVM-Singleton-UnitTesting-Web-Api-Call-Clean-Code


Architecture:
It has MVVM Architecture. ViewControllers are responsible for displaying data and getting data from ViewModel. ViewModel have only business logic that they apply on data, they get from Manager. Manager communicate with Web Manager and DataManager and provide data to ViewModel. DataManger are responsible for writing and reading data from Local storage. WebManager is responsible for getting data from Web Server. In addition to that there are different individual modules that are following single responsibility principle.


Attractions of the project:

Design Patterns: 
- Singleton: “EarthQuakeManager, EarthQuakeDataManager, EarthQuakeWebManager”
- Strategy Pattern: “EarthQuakeManagementProvider” is and example of this pattern. By using this, I am able to add one layer between Manager and ViewModel and that layer will help me insert MockManager for Unit test code of “EarthQuakeViewModelTests”.
- Bulder Pattern: “func generateEarthQuakeDetailModel(earthquake: EarthQuakeProperties)”  is a very small example of Builder pattern.
- Adaptive: Each model in this project is Adaptive, new properties are introduced in extensions. Example: “extension EarthQuakeProperties”, “extension Paginator”
- Abstract Decorator Pattern:  It is kind of Decorator pattern. Example: “protocol AccessibilityProtocol”
- Memento: Apple’s default Codable and Decodable. All models coming from server are following this pattern.
- DataSource Decoupling Pattern:  “EarthQuakesDataSource”.


Unit Testing:
- I have implemented one example of ViewModel Unit testing and one example of Module Unit Testing.
EarthQuakeViewModelTests and PaginatorTests. In EarthQuakeViewModelTests I was able to mock Manger using EarthQuakeManagementProvider which is part of Strategy Design Pattern. Pagination is independent module that can be tested very easily. I have implemented that as well.

UI Testing:
- I have tried to implement one small example of UITesting but it fails. I was not able to complete that due to unknown Linker error that Xcode 12.4 is throwing I will work on that and that was resisting me from creating mock of project target. But I have implemented small static example in which we can mock EarthQuakeViewModel as we did in Unit testing and then we can check values inside UIElement against that mocks.

Local Database: 
- Options available to me were Core Data, Realm, File and UserDefault. I choose UserDefault for this project because data that we are storing is pretty small and simple. I have just implemented very basing caching. I did not implemented syncing database with Web due to limited availability of time. It will just store the previous data and read from it. If we want to do syncing then we can have some add ons in EarthQuakeManager.

Why did I have two separate two view controllers for iOS 13 and above and 12:
- There are two options: First one is to have same view controller and different views WebView and WKWebView and then we can implement everything else based on iOS version but it would be way complicated to operate on same controller when we have different complex functionality since we have operate on their delegates.
- I choose to go for separate ViewControllers but in shared logic. They both will be using same viewModel so they share same business logic and for UI part they confirms to WebViewProvider. This way we just have to route based on version once instead of having same condition at all level. Also we can easily work with their individual delegates.


