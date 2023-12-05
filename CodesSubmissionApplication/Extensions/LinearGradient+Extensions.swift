//
//  LinearGradient+Extensions.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//

import SwiftUI

extension LinearGradient {

    static let appBackground = LinearGradient(
        colors: [.purple, .orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let appBackgroundDetails = LinearGradient(
        colors: [.yellow, .red],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
