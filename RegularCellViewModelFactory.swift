//
//  RegularCellViewModelFactory.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 25.03.2022.
//

import UIKit

final class RegularCellViewModelFactory {
    
    var cellDataItem: [CellDataItem] = []
    
    func constructViewModels(from cellData: [CellDataItem]) -> [RegularCellViewModel] { return cellData.compactMap(self.viewModel)
    }
    
    private func viewModel(from cellDataItem: CellDataItem) -> RegularCellViewModel {
        let regularCellText = cellDataItem.name
        let regularCellDateText = RegularCellViewModelFactory.dateFormatter.string(from: cellDataItem.date)
        let regularCellImageURL = cellDataItem.imageURL
        let regularCellTextShadowColor = cellDataItem.textShadowColor
        let regularCellBackgroundColor = cellDataItem.cellBackgroundColor
        return RegularCellViewModel(regularCellText: regularCellText, regularCellDateText: regularCellDateText, regularCellImageURL: regularCellImageURL, regularCellTextShadowColor: regularCellTextShadowColor, regularCellBackgroundColor: regularCellBackgroundColor)
    }

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        return dateFormatter
    }()
}
