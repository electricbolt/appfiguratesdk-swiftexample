// ExampleApp.swift
// SwiftExample Copyright© 2026; Electric Bolt Limited.

import SwiftUI

@main
struct ExampleApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ExampleView()
        }
    }
}
