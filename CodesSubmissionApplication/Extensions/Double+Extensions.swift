//
//  Double+Extensions.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 03.12.2023.
//

import Foundation

extension Double? {

    var toString: String? {
        guard let self else { return nil }
        return "\(self)"
    }
}
