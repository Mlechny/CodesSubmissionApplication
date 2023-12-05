//
//  LanguageEntity.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 03.12.2023.
//

import Foundation

struct LanguageEntity: Decodable {
    var languageId: String?
    var name: String?
    var subject: String?
    var imageURL: String?
    var task: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
            case languageId = "uuid",
                 name,
                 subject
            case imageURL = "image_url",
                 task,
                 description
        }
}
// MARK: - Mapper

extension LanguageEntity {

    var mapper: LanguageModel {
        LanguageModel(
            languageId: languageId,
            name: name,
            subject: subject,
            imageURL: ("http://"+(imageURL ?? "")).replacingOccurrences(of: "localhost", with: "172.20.10.4").toURL,
            task: task,
            description: description
        )
    }
}
