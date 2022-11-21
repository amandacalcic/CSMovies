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
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private let apiKey = "556260fab287adbcca1308d5498cff79"
    
    func ImageApiRequest(urlPath: String, method: HttpMethod) -> Observable<Data> {
        guard let request = APIRequest(url: imageBaseURL + urlPath, method: method) else { return Observable.empty()}
        return APICall(request: request)
    }
    
    func ApiRequest(method: HttpMethod, urlPath: String, parameters: [String: Any]? = nil) -> Observable<Data> {
        guard let request = APIRequest(url: baseURL + urlPath, method: method, parameters: parameters) else { return Observable.empty() }
        return APICall(request: request)
    }
    
    private func APICall(request: URLRequest) -> Observable<Data> {
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        return Observable.create {observer in
            let task = defaultSession.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    observer.onError(error ?? NSError())
                    observer.onCompleted()
                    return
                }
                
                if let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode {
                    observer.onNext(data)
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
    
    func convertDataToJSON(with data: Data) -> JSON {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let json = JSON(jsonObject)
            return json
        } catch {
            debugPrint("JSON Error = \(error)")
            return JSON()
        }
    }
}
