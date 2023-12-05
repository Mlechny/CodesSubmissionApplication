//
//  APIManager.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 03.12.2023.
//
import Foundation

final class APIManager {

    private init() {}

    static let shared = APIManager()

    func getLanguages(completion: @escaping (Result<[LanguageModel], APIError>) -> Void) {
        let urlString = "http://172.20.10.4:8080/api/languages"
        guard let url = URL(string: urlString) else {
            //print(1)
            completion(.failure(.incorrectlyURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    print(2)
                    completion(.failure(.error(error)))
                }
                return
            }
            /// Приводим `response` к типу HTTPURLResponse
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    //print(3)
                    completion(.failure(.responseIsNil))
                }
                return
            }
            /// Провекра кода ответа
            guard (200..<300).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    //print(4)
                    completion(.failure(APIError.badStatusCode(response.statusCode)))
                }
                return
            }
            /// Распаковка дата
            guard let data else {
                DispatchQueue.main.async {
                    //print(5)
                    completion(.failure(.dataIsNil))
                }
                return
            }
            do {
                let collections = try JSONDecoder().decode(CollectionEntity.self, from: data)
                /// Т.к в коллекциях у нас лежит массив `SongEntity`, то мы перебираем массив и маппим их в `SongModel`
                DispatchQueue.main.async {
                    //print(collections)
                    let temp = collections.languages.map { $0.mapper }
                    //print(temp)
                    completion(.success(temp))
                }
                return

            } catch {
                DispatchQueue.main.async {
                    print(7)
                    completion(.failure(.error(error)))
                }
            }
        }.resume()
    }
}
