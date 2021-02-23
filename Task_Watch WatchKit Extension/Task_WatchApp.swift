//
//  Task_WatchApp.swift
//  Task_Watch WatchKit Extension
//
//  Created by Michele Manniello on 23/02/21.
//

import SwiftUI

@main
struct Task_WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
