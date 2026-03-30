@testable import ConfidentialObfuscator
import XCTest

final class ConfidentialObfuscatorTests: XCTestCase {

    func test_givenConfig_whenObfuscate_thenReturnsStringWithObfuscatedSecrets() throws {
        // given
        let value: String = "variable_value"

        let configuration = """
            algorithm:
              - encrypt using aes-128-gcm
            defaultAccessModifier: public
            secrets:
              - name: variable_name
                value: \(value)
            """

        // when
        let obfuscatedString: String = try ConfidentialObfuscator.obfuscate(configurationData: Data(configuration.utf8))

        // then


        let expectedString: String = """
        import ConfidentialKit
        
        extension ConfidentialCore.Obfuscation.Secret {
        
            public static #Obfuscate(algorithm: .custom([.encrypt(algorithm: .aes128GCM)])) {
                let variable_name = "\(value)"
            }
        }
        """

        XCTAssertEqual(obfuscatedString, expectedString.trimmingCharacters(in: .newlines))
    }
}
