//
//  QuestionsService.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 06/01/2024.
//

import Foundation

enum ErrorDetail: Swift.Error {
	case errorURL(urlString: String)
	case detailError(detail: String)
}

class QuestionsService {
	func fetchQuestionsData(completion: @escaping(QuestionsData?, Error?) -> Void) {
		let urlString: String = "https://run.mocky.io/v3/6ae8ee61-9495-47de-8b0d-2f53b958ce74"
		guard let url: URL = URL(string: urlString) else { return completion(nil, ErrorDetail.errorURL(urlString: urlString)) }
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let dataResult = data else { return completion(nil, ErrorDetail.detailError(detail: "Couldn't fetch any data from specified URL")) }
			guard let response = response as? HTTPURLResponse else { return }
			if response.statusCode == 200 {
				do {
					let questionsData: QuestionsData = try JSONDecoder().decode(QuestionsData.self, from: dataResult)
					completion(questionsData, nil)
				} catch {
					completion(nil, error)
				}
			} else {
				completion(nil, error)
			}
		}
		task.resume()
	}
}
