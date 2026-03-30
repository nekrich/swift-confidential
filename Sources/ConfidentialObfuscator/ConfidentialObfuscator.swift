import ConfidentialParsing
import Foundation

/// Obfuscates a source file based on a configuration.
public enum ConfidentialObfuscator {
    /// Creates a string with obfuscated source code based on a given configuration data.
    ///
    /// - Parameters:
    ///   - configurationData: The `Data` contents of a YAML file containing the configuration.
    /// - Returns: A string with obfuscated source code.
    /// - Throws: An error if the configuration is invalid or the obfuscation fails.
    public static func obfuscate(configurationData: Data) throws -> String {
        let sourceFileText: SourceFileText = try ConfidentialParser()
            .parse(configurationData)

        return sourceFileText.description
    }
}
