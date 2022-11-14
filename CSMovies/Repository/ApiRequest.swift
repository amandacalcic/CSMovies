//
//  ApiRequest.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import Foundation
import RxSwift
import SwiftyJSON

class ApiRequest {
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "556260fab287adbcca1308d5498cff79"
    
    func APICall(method: HttpMethod, urlPath: String, parameters: [String: Any]? = nil) -> Observable<JSON> {
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        return Observable.create { [weak self] observer in
            guard let self = self, let request = self.APIRequest(url: self.baseURL + urlPath, method: method, parameters: parameters) else { return Disposables.create() }
            
            let task = defaultSession.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    observer.onError(error ?? NSError())
                    observer.onCompleted()
                    return
                }
                
                if let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode {
                    let json = self.convertDataToJSON(with: data)
                    observer.onNext(json)
                } else {
                    observer.onError(error ?? NSError())
                }
                
                observer.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func APIRequest(url: String, method: HttpMethod, parameters: [String: Any]? = nil) -> URLRequest? {
        guard let root = URL(string: url) else { return nil }
        
        var request = URLRequest(url: root)
        
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let urlComponents = urlParams(url: url, parameters: parameters)
        request.url = urlComponents?.url
        
        return request
    }
    
    private func urlParams(url:String, parameters: [String: Any]? = nil) -> URLComponents? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        
        var params = [URLQueryItem]()
        params.append(URLQueryItem(name: "api_key", value: "\(apiKey)"))
        
        if let parameters = parameters {
            params.append(contentsOf: parameters.map { URLQueryItem(name: $0, value: "\($1)") })
        }
        
        urlComponents.queryItems = params
        
        return urlComponents
    }
    
    private func convertDataToJSON(with data: Data) -> JSON {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let json = JSON(jsonObject)
            return json
        } catch {
            debugPrint("Erro parse JSON = \(error)")
            return JSON()
        }
    }
}
