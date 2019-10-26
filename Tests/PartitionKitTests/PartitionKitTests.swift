import XCTest
@testable import PartitionKit

final class PartitionKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PartitionKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
