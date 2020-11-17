import XCTest
@testable import SIPrefix

final class SIPrefixTests: XCTestCase {
    func testDefaultFormatter() {
        let formatter = SIPrefixFormatter()
        XCTAssertEqual(formatter.format(1), "1")
        XCTAssertEqual(formatter.format(23), "23")
        XCTAssertEqual(formatter.format(345), "345")
        XCTAssertEqual(formatter.format(4_567), "5k")
        XCTAssertEqual(formatter.format(56_789), "57k")
        XCTAssertEqual(formatter.format(678_901), "679k")
        XCTAssertEqual(formatter.format(7_890_123), "8M")
        XCTAssertEqual(formatter.format(89_012_345), "89M")
        XCTAssertEqual(formatter.format(901_234_567), "901M")
        XCTAssertEqual(formatter.format(1_234_567_890), "1G")
        XCTAssertEqual(formatter.format(23_456_789_012), "23G")
        XCTAssertEqual(formatter.format(345_678_901_234), "346G")
        XCTAssertEqual(formatter.format(4_567_890_123_456), "5T")
        XCTAssertEqual(formatter.format(9_223_372_036_854_775_807), "9E")
        XCTAssertEqual(formatter.format(-1), "-1")
        XCTAssertEqual(formatter.format(-23), "-23")
        XCTAssertEqual(formatter.format(-345), "-345")
        XCTAssertEqual(formatter.format(-4_567), "-5k")
        XCTAssertEqual(formatter.format(-56_789), "-57k")
        XCTAssertEqual(formatter.format(-678_901), "-679k")
        XCTAssertEqual(formatter.format(-7_890_123), "-8M")
        XCTAssertEqual(formatter.format(-89_012_345), "-89M")
        XCTAssertEqual(formatter.format(-901_234_567), "-901M")
        XCTAssertEqual(formatter.format(-1_234_567_890), "-1G")
        XCTAssertEqual(formatter.format(-23_456_789_012), "-23G")
        XCTAssertEqual(formatter.format(-345_678_901_234), "-346G")
        XCTAssertEqual(formatter.format(-4_567_890_123_456), "-5T")
        XCTAssertEqual(formatter.format(-9_223_372_036_854_775_807), "-9E")
    }
    
    func testCustomFormatter() {
        let formatter = SIPrefixFormatter(prefixes: [
            .init(log10: 1, symbol: "da"),
            .init(log10: 2, symbol: "h"),
            .init(log10: 3, symbol: "k"),
            .init(log10: 6, symbol: "M"),
        ])
        XCTAssertEqual(formatter.format(1), "1")
        XCTAssertEqual(formatter.format(23), "2da")
        XCTAssertEqual(formatter.format(345), "3h")
        XCTAssertEqual(formatter.format(4_567), "5k")
        XCTAssertEqual(formatter.format(56_789), "57k")
        XCTAssertEqual(formatter.format(678_901), "679k")
        XCTAssertEqual(formatter.format(7_890_123), "8M")
        XCTAssertEqual(formatter.format(89_012_345), "89M")
        XCTAssertEqual(formatter.format(901_234_567), "901M")
        XCTAssertEqual(formatter.format(1_234_567_890), "1235M")
        XCTAssertEqual(formatter.format(-1), "-1")
        XCTAssertEqual(formatter.format(-23), "-2da")
        XCTAssertEqual(formatter.format(-345), "-3h")
        XCTAssertEqual(formatter.format(-4_567), "-5k")
        XCTAssertEqual(formatter.format(-56_789), "-57k")
        XCTAssertEqual(formatter.format(-678_901), "-679k")
        XCTAssertEqual(formatter.format(-7_890_123), "-8M")
        XCTAssertEqual(formatter.format(-89_012_345), "-89M")
        XCTAssertEqual(formatter.format(-901_234_567), "-901M")
        XCTAssertEqual(formatter.format(-1_234_567_890), "-1235M")
    }
    
    func testJapaneseFormatter() {
        let formatter = SIPrefixFormatter(prefixes: [
            .init(log10: 2, symbol: "百"),
            .init(log10: 3, symbol: "千"),
            .init(log10: 4, symbol: "万"),
            .init(log10: 8, symbol: "億"),
        ], recursive: true)
        XCTAssertEqual(formatter.format(1), "1")
        XCTAssertEqual(formatter.format(23), "23")
        XCTAssertEqual(formatter.format(345), "3百")
        XCTAssertEqual(formatter.format(4_567), "5千")
        XCTAssertEqual(formatter.format(56_789), "6万")
        XCTAssertEqual(formatter.format(678_901), "68万")
        XCTAssertEqual(formatter.format(7_890_123), "8百万")
        XCTAssertEqual(formatter.format(89_012_345), "9千万")
        XCTAssertEqual(formatter.format(901_234_567), "9億")
        XCTAssertEqual(formatter.format(1_234_567_890), "12億")
        XCTAssertEqual(formatter.format(23_456_789_012), "2百億")
        XCTAssertEqual(formatter.format(-1), "-1")
        XCTAssertEqual(formatter.format(-23), "-23")
        XCTAssertEqual(formatter.format(-345), "-3百")
        XCTAssertEqual(formatter.format(-4_567), "-5千")
        XCTAssertEqual(formatter.format(-56_789), "-6万")
        XCTAssertEqual(formatter.format(-678_901), "-68万")
        XCTAssertEqual(formatter.format(-7_890_123), "-8百万")
        XCTAssertEqual(formatter.format(-89_012_345), "-9千万")
        XCTAssertEqual(formatter.format(-901_234_567), "-9億")
        XCTAssertEqual(formatter.format(-1_234_567_890), "-12億")
        XCTAssertEqual(formatter.format(-23_456_789_012), "-2百億")
    }
    
    func testShiftedFormatter() {
        let formatter = SIPrefixFormatter(
            prefixes: [
                .init(log10: 3,  symbol: "k"),
                .init(log10: 6,  symbol: "M"),
            ],
            numberFormat: "%.1f",
            shift: 1
        )
        XCTAssertEqual(formatter.format(1), "1.0")
        XCTAssertEqual(formatter.format(23), "23.0")
        XCTAssertEqual(formatter.format(345), "0.3k")
        XCTAssertEqual(formatter.format(4_567), "4.6k")
        XCTAssertEqual(formatter.format(56_789), "56.8k")
        XCTAssertEqual(formatter.format(678_901), "0.7M")
        XCTAssertEqual(formatter.format(7_890_123), "7.9M")
        XCTAssertEqual(formatter.format(89_012_345), "89.0M")
        XCTAssertEqual(formatter.format(901_234_567), "901.2M")
        XCTAssertEqual(formatter.format(1_234_567_890), "1234.6M")
        XCTAssertEqual(formatter.format(-1), "-1.0")
        XCTAssertEqual(formatter.format(-23), "-23.0")
        XCTAssertEqual(formatter.format(-345), "-0.3k")
        XCTAssertEqual(formatter.format(-4_567), "-4.6k")
        XCTAssertEqual(formatter.format(-56_789), "-56.8k")
        XCTAssertEqual(formatter.format(-678_901), "-0.7M")
        XCTAssertEqual(formatter.format(-7_890_123), "-7.9M")
        XCTAssertEqual(formatter.format(-89_012_345), "-89.0M")
        XCTAssertEqual(formatter.format(-901_234_567), "-901.2M")
        XCTAssertEqual(formatter.format(-1_234_567_890), "-1234.6M")
    }
}
