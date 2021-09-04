//
//  UITestingTutorialUITests.swift
//  UITestingTutorialUITests
//
//  Created by k-aoki on 2021/09/04.
//

import XCTest

class UITestingTutorialUITests: XCTestCase {

    override func setUpWithError() throws {

        // テストが失敗した時に後続のテストを止めるか
        continueAfterFailure = false
        
        XCUIApplication().launch()
    }


    // 下の録画ボタンをタップし、実際に操作する
    func test_valid_login_success() {
        
        let validUsername = "CodePro"
        let validPassword = "abc123"

        let app = XCUIApplication()

        app.navigationBars["Mockify Music"].buttons["Profile"].tap()

        let usernameTextField = app.textFields["Username"] // textFieldの場合、Placeholderが入っていないと指定方法が異なる
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(validUsername)

        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword) // キーボードが出ていないと失敗する

        app.buttons["Login"].tap()

        let downloadsCell = app.tables.staticTexts["My Downloads"]

        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadsCell, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(downloadsCell.exists)
    }
    
    
    func test_invalid_login_missing_credentials_alert_is_shown() {
        
        let app = XCUIApplication()

        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        
        app.buttons["Login"].tap()
        let alertDialog = app.alerts["Missing Credentials"]
                
        XCTAssertTrue(alertDialog.exists)
        alertDialog.scrollViews.otherElements.buttons["Ok"].tap()
    }
    
    func test_invalid_login_progres_spinner_is_hidden() {

        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app.buttons["Login"].tap()
        app.alerts["Missing Credentials"].buttons["Ok"].tap()
                
        let indicator = app.activityIndicators["In progress"]
        XCTAssertFalse(indicator.exists)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
