//
//  AppDelegate.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

//        let apiService = APIService(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjNhMmI4OTQ3NzA2NGJkNzk3Njg5YTA2N2RjZmZmMCIsIm5iZiI6MTczODkwNTIwMS45Mjk5OTk4LCJzdWIiOiI2N2E1OTY3MTRkNTM2Y2I5MzI2NmQ1NzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.z_RIbAKn-3nU77dQb8ewaloxaIxx7u_HfcmnKA0YN2o")
//             let fetchUsersUseCase = DefaultFetchUsersUseCase(apiService: apiService)
//             let searchUseCase = SearchUseCase(apiService: apiService)
//             let userListViewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase, searchUseCase: searchUseCase)
//             let userListViewController = UserListViewController()
//             userListViewController.viewModel = userListViewModel
//        
//        
//        let navigationController = UINavigationController(rootViewController: userListViewController)
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        print("App launched")
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
           print("App will resign active")
       }

       func applicationDidEnterBackground(_ application: UIApplication) {
           print("App entered background")
       }

       func applicationWillEnterForeground(_ application: UIApplication) {
           print("App will enter foreground")
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
           print("App became active")
       }

       func applicationWillTerminate(_ application: UIApplication) {
           print("App will terminate")
       }
    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CleanArchitectureWithMvvm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

