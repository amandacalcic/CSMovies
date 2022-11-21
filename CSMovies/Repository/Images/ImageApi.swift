//
//  ImageApi.swift
//  CSMovies
//
//  Created by Amanda Calcic on 21/11/22.
//

import Foundation
import RxSwift

protocol ImageApiProtocol {
    func getImageFromURL(with imageURL: String) -> Observable<Data>
}

class ImageApi: ImageApiProtocol {
    private let apiRequest = ApiRequest()
    
    func getImageFromURL(with imageURL: String) -> Observable<Data> {
        let imageData = apiRequest.ImageApiRequest(urlPath: imageURL, method: .get)
        return imageData
    }
}
