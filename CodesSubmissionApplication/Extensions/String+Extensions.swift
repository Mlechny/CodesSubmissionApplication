//
//  String+Extensions.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 03.12.2023.
//

import Foundation

extension String {

    var toURL: URL? { URL(string: self) }
}
