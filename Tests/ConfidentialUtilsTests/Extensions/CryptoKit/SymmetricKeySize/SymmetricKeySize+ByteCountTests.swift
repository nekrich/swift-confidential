@testable import ConfidentialUtils
import XCTest

#if os(Linux)
import Crypto
#else
import CryptoKit
#endif

final class SymmetricKeySize_ByteCountTests: XCTestCase {

    func test_givenStandardKeySize_whenByteCount_thenReturnsExpectedValue() {
        // given
        let keySize = SymmetricKeySize.bits192

        // when
        let byteCount = keySize.byteCount

        // then
        XCTAssertEqual(24, byteCount)
    }

    func test_givenNonStandardKeySize_whenByteCount_thenReturnsExpectedValue() {
        // given
        let keySize = SymmetricKeySize(bitCount: 72)

        // when
        let byteCount = keySize.byteCount

        // then
        XCTAssertEqual(9, byteCount)
    }
}
