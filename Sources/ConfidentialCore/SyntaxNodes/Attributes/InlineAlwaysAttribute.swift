import SwiftSyntax

extension AttributeSyntax {

    static var inlineAlways: Self {
        .init("inline(__always)")
    }
}
