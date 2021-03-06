//
//  ALKConversationViewControllerTests.swift
//  ApplozicSwiftDemoTests
//
//  Created by Mukesh Thawani on 20/07/18.
//  Copyright © 2018 Applozic. All rights reserved.
//

import XCTest
@testable import ApplozicSwift

class ALKConversationViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testObserver_WhenInitializing() {

        // Subclass ALKConversationViewController to test if `addObserver` method is getting triggered.
        class TestVC: ALKConversationViewController {

            var rootExpectation: XCTestExpectation!

            init(expectation: XCTestExpectation) {
                rootExpectation = expectation
                super.init(configuration: ALKConfiguration())
            }

            required init(configuration: ALKConfiguration) {
                super.init(configuration: configuration)
            }

            required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }

            override func addObserver() {
                rootExpectation.fulfill()
            }
        }
        let vcExpectation = expectation(description: "Observer called")
        _ = TestVC(expectation: vcExpectation)
        waitForExpectations(timeout: 0, handler: nil)
    }
    
    func testTypingStatusInGroup_UseDisplayName() {
        let conversationVC = ALKConversationViewControllerMock(configuration: ALKConfiguration())
        conversationVC.viewModel = ALKConversationViewModelMock(contactId: nil, channelKey: 000, localizedStringFileName: ALKConfiguration().localizedStringFileName)
        conversationVC.contactService = ALContactServiceMock()
        conversationVC.showTypingLabel(status: true, userId: "demoUserId")
        XCTAssertEqual("demoDisplayName", conversationVC.testDisplayName)
    }
    
    func testTypingStatusInGroup_UseSomebody() {
        var configuration = ALKConfiguration()
        configuration.showNameWhenUserTypesInGroup = false
        let conversationVC = ALKConversationViewControllerMock(configuration: configuration)
        conversationVC.viewModel = ALKConversationViewModelMock(contactId: nil, channelKey: 000, localizedStringFileName: ALKConfiguration().localizedStringFileName)
        conversationVC.contactService = ALContactServiceMock()
        conversationVC.showTypingLabel(status: true, userId: "demoUserId")
        XCTAssertEqual("Somebody", conversationVC.testDisplayName)
    }
}
