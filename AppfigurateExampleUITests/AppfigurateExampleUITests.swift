// AppfigurateExampleUITests.swift
// AppfigurateExample Copyright© 2020-2024; Electric Bolt Limited.
 
import XCTest
import AppfigurateLibrary

/**
Appfigurate can be used to configure an iOS application undergoing UI testing.
To setup, you must perform the following in your UI Testing bundle:
1. Link the AppfigurateLibrary static xcframework.
2. Tick on your APLConfiguration subclass in target membership.
3. Ensure your APLConfiguration subclass allowInvalidSignatures method returns true for a DEBUG build.
4. Optionally add a UIInterruptionMonitor to automatically dismiss the Appfigurate alert, when configuration is applied.
5. Get an instance of your APLConfiguration subclass and set properties.
6. Apply the resulting configuration to XCUIApplication and launch.
*/

class AppfigurateExampleUITests: XCTestCase {

    var config: ExampleConfiguration!
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
    
        // Automatically dismiss the Appfigurate "Configuration applied" dialog.
        addUIInterruptionMonitor(withDescription: "Appfigurate") { (element) -> Bool in
            if (element.elementType == .alert) {
                if (element.buttons["OK"].exists) {
                    element.buttons["OK"].tap()
                    return true
                } else if (element.buttons["Ignore"].exists) {
                    element.buttons["Ignore"].tap()
                    return true
                }
            }
            return false
        }
        
        config = APLConfiguration.shared() as? ExampleConfiguration
        app = XCUIApplication()
    }

    override func tearDown() {
    }

    func testLaunchReset() {
        app.launchArguments = config.automationLaunchArgumentsReset()
        app.launch()

        let cell = app.tables.cells.element(boundBy: 0)
        let text = cell.staticTexts.element(boundBy: 1)
        XCTAssertEqual(text.label, "true")
    }
    
    func testLaunchApplyBooleanValue() {
        config.boolean = false
        app.launchArguments = config.automationLaunchArguments()
        app.launch()

        let cell = app.tables.cells.element(boundBy: 0)
        let text = cell.staticTexts.element(boundBy: 1)
        XCTAssertEqual(text.label, "false")
    }

    func testLaunchApplyStringTextFieldValue() {
        config.string_Textfield = "thursday"
        app.launchArguments = config.automationLaunchArguments()
        app.launch()
        
        let cell = app.tables.cells.element(boundBy: 1)
        let text = cell.staticTexts.element(boundBy: 1)
        XCTAssertEqual(text.label, "thursday")
    }
    
    func testLaunchAction() {
        app.launchArguments = config.automationLaunchArguments(withAction: "randomIntegers")
        app.launch()

        let cell = app.tables.cells.element(boundBy: 8)
        let text = cell.staticTexts.element(boundBy: 1)
        // The integer_Slider field should now be equal to some random value other
        // than the default number of 500.
        XCTAssertNotEqual(text.label, "500");
    }
    
    func testSendMessageToApplicationUnderTest() {
        app.launchArguments = config.automationLaunchArgumentsReset()
        app.launch()

        // Invokes the APLAutomationMessageReceivedBlock callback in SwiftExample.AppDelegate class. Sets the app's dark mode value to dark.
        APLAutomationSendMessage("SetDarkMode", true, 3.0)
        
        // Invokes the APLAutomationMessageReceivedBlock callback in SwiftExample.AppDelegate class. Reads the app's dark mode value.
        XCTAssertTrue(APLAutomationSendMessage("GetDarkMode", nil, 3.0) as! Bool)
    }
    
    func testApplyAndReadConfiguration() {
        app.launchArguments = config.automationLaunchArguments(withAction: "randomIntegers")
        app.launch()

        // Updates this configuration by reading the configuration from the app under test.
        config.automationSendReadConfiguration()
        
        let cell = app.tables.cells.element(boundBy: 8)
        let text = cell.staticTexts.element(boundBy: 1)
        XCTAssertEqual(text.label, "\(config.integer_Slider)");

        // Applies this configuration to the app under test.
        config.integer_Slider = 30
        config.automationSendConfiguration()
        XCTAssertEqual(text.label, "30");
    }
}
