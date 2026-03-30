@testable import ConfidentialParsing
import XCTest

import SwiftSyntax

final class SourceFileTextTests: XCTestCase {

    private typealias SUT = SourceFileText

    func test_givenSourceFileTextWithSourceFileSyntax_whenGetText_thenReturnsExpectedSyntaxText() {
        // given
        let sourceFile = SourceFileSyntax(
            statements: CodeBlockItemListSyntax {
                CodeBlockItemSyntax(
                    item: .init(
                        ImportDeclSyntax(
                            path: [ImportPathComponentSyntax(name: .identifier("Foundation"))]
                        )
                    ),
                    trailingTrivia: .newline
                )
                CodeBlockItemSyntax(
                    item: .init(
                        StructDeclSyntax(
                            structKeyword: .keyword(.struct, leadingTrivia: .newline),
                            name: "Test",
                            memberBlock: .init(
                                leftBrace: .leftBraceToken(leadingTrivia: .space),
                                rightBrace: .rightBraceToken()
                            ) {
                                VariableDeclSyntax(
                                    .let,
                                    name: PatternSyntax(stringLiteral: "id"),
                                    type: TypeAnnotationSyntax(type: TypeSyntax(stringLiteral: "UUID"))
                                )
                                VariableDeclSyntax(
                                    .var,
                                    name: PatternSyntax(stringLiteral: "data"),
                                    type: TypeAnnotationSyntax(type: TypeSyntax(stringLiteral: "Data"))
                                )
                            }
                        )
                    )
                )
            }
        )
        let sut = SUT(from: sourceFile)

        // when
        let sourceFileText = sut.description

        // then
        XCTAssertEqual(
            """
            import Foundation

            struct Test {
            \(C.Code.Format.indentWidth)let id: UUID
            \(C.Code.Format.indentWidth)var data: Data
            }
            """,
            sourceFileText
        )
    }
}
