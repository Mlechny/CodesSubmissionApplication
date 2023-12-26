//
//  LanguageEntity.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 03.12.2023.
//

import Foundation

struct GetAllLanguagesResponse: Decodable {
    let languages: [LanguageEntity]
    
    enum CodingKeys: String, CodingKey {
            case languages
        }
}

struct LanguageEntity: Decodable {
    let uuid: String
    let name: String?
    let subject: String?
    let image_url: String?
    let task: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
            case uuid,
                 name,
                 subject,
                 image_url,
                 task,
                 description
            }
}
// MARK: - Mapper

extension LanguageEntity {
    var mapper: LanguageModel {
            return LanguageModel(
                languageId: uuid,
                name: name,
                subject: subject,
                task: task,
                description: description,
                imageURLString: image_url
            )
        }
}
