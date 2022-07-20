//
//  MoneyModel.swift
//  Le Baluchon
//
//  Created by Sam on 09/07/2022.
//

import Foundation

struct MoneyModel
{
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let currencyData: [String: Double]

    init(apiModel: MoneyResponse)
    {
        currencyData = apiModel.rates
        timestamp = apiModel.timestamp
        success = apiModel.success
        base = apiModel.base
        date = apiModel.date
    }
}
