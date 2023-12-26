//
//  MainViewModel.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//

import Foundation

/// Это наш собственный протокол, в котором мы будем прописывать функции, которые мы должны реализовать дальше.
protocol MainViewModelProtocol {
    func searchTitles(searchText: String, fetchData: () -> Void, fetchSearch: (String) -> Void) -> [LanguageModel]
    func getLanguages(completion: @escaping (Error?) -> Void)
    func getDetails(LanguageId: String, completion: @escaping (Error?) -> Void)
}

/// Это наш основной класс, который будет хранить все треки, полученные из АПИ.
/// Слово final говорит, что это конечный класс и наследоваться от него мы не будем
final class MainViewModel: ObservableObject {

    @Published var languages: [LanguageModel] = []
    @Published var language: LanguageModel = LanguageModel()
    
}

// MARK: - MainViewModelProtocol

/// Подписываемся на наш протокл, где в дальнейшем будем реализовывать функции
extension MainViewModel: MainViewModelProtocol {
    
    /// Фильтрация при поиске
    /// - Parameter searchText: текст из сёрч бара
    /// - Returns: массив отфильтрованных песен
    func getSearch(searchStr: String, completion: @escaping (Error?) -> Void) {
        APIManager.shared.getSearch (searchStr: searchStr, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                languages = data
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
    
    func getLanguages(completion: @escaping (Error?) -> Void) {
        APIManager.shared.getLanguages { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                languages = data
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getDetails(LanguageId: String, completion: @escaping (Error?) -> Void) {
        APIManager.shared.getDetails (LanguageId: LanguageId, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                language = data
                print(language.description)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
    
    func searchTitles(searchText: String, fetchData: () -> Void, fetchSearch: (String) -> Void) -> [LanguageModel] {
        if searchText.isEmpty {
            return languages
        } else {
            return languages
        }
    }
}
