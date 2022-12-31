import XCTest
@testable import DeclarativeLogging

final class LoggableTests: XCTestCase {
    func testEmptyString() throws {
        var loggingCount = NSNumber(integerLiteral: 0)
        @Loggable(when: { $0.isEmpty }, loggingCount: &loggingCount) var string = "Hello"
        XCTAssertEqual(loggingCount, NSNumber(integerLiteral: 0))
        string = ""
        XCTAssertEqual(loggingCount, NSNumber(integerLiteral: 1))
    }
    
    func testZeroInt() throws {
        var loggingCount = NSNumber(integerLiteral: 0)
        @Loggable(when: { $0 == 0 }, loggingCount: &loggingCount) var int = 1
        XCTAssertEqual(loggingCount, NSNumber(integerLiteral: 0))
        int = 0
        XCTAssertEqual(loggingCount, NSNumber(integerLiteral: 1))
    }
}
