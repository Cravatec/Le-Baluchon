//
//  Translate.swift
//  Le Baluchon
//
//  Created by Sam on 07/07/2022.
//

import Foundation


struct TranslateModel {
    let translatedText: String
    
    init(apiModel: TranslateResponse) {
        translatedText = apiModel.data.translations[0].translatedText
    }
}

struct TranslateResponse: Decodable {
    let data: DataTranslate
}

struct DataTranslate: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
