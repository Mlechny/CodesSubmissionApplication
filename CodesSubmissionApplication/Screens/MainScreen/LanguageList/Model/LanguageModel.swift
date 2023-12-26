//
//  LanguageModel.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//
import Foundation

struct LanguageModel: Identifiable {
    let id = UUID()
    var languageId: String?
    var name: String?
    var subject: String?
    var imageURL: URL?
    var task: String?
    var description: String?
}

extension LanguageModel {
    init(languageId: String?, name: String?, subject: String?, task: String?, description: String?, imageURLString: String?) {
            self.languageId = languageId
            self.name = name
            self.subject = subject
            self.task = task
            self.description = description
            // Связывание опциональной строки с URL
            if let imageURLString = imageURLString {
                let imageURLStringHost = imageURLString.replacingOccurrences(of: "localhost", with: host)
                self.imageURL = URL(string: "http://" + imageURLStringHost)
            } else {
                self.imageURL = nil // В случае, если строка imageURLString пуста
            }
        }
}

extension LanguageModel {
    var mapper: LanguageEntity {
            let imageURLStringHost = imageURL?.absoluteString.replacingOccurrences(of: "localhost", with: host)
        
            return LanguageEntity(
                uuid: languageId ?? "00000000-0000-0000-0000-000000000000",
                name: name,
                subject: subject,
                image_url: imageURLStringHost,
                task: task,
                description: description
            )
        }
}

// MARK: - Mock data

/// Это наши моки для вёрстки для SongModel
extension LanguageModel {

    static let mockData = LanguageModel(
        languageId: "10023",
        name: "Python",
        subject: "Парадигмы и конструкции языков программирования",
        imageURL: .mockData,
        task: "Лабораторная работа 2",
        description: "На шахматной доске 8 х 8 стоит ферзь. Отметьте положение ферзя на доске и все клетки, которые бьет ферзь. Клетку, где стоит ферзь, отметьте буквой Q, клетки, которые бьет ферзь, отметьте звездочками *, остальные клетки заполните точками. Шахматный ферзь может ходить по вертикали, горизонтали и по диагоналям."
    )
}

/// Это наши моки для вёрстки для массива SongModel
extension [LanguageModel] {

    static let mockData = (1...20).map {
        LanguageModel(
            languageId: "f0babc39-54d0-41e7-8592-e1156dc725aa \(String(describing: $0))",
            name: "Язык программирования \(String(describing: $0))",
            subject: "Название предмета \(String(describing: $0))",
            imageURL: .mockData,
            task: "Тип задания \(String(describing: $0))",
            description: "Описание задания \(String(describing: $0))"
        )
    }
}

/// Это наши мок фото из интернета.
private extension URL {

    static let mockData = URL(string: "http://172.20.10.4:9000/images/e7c4249c-b75a-419f-b446-ecdce48919c7.jpg")
}
