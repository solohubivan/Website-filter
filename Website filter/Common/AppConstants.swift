//
//  AppConstants.swift
//  Website filter
//
//  Created by Ivan Solohub on 07.02.2024.
//

import Foundation

enum AppConstants {
    
    enum Alerts {
        static let noInternetAlertTitle: String = "Internet connection is unavailable"
        static let noInternetAlertMessage: String = "please allow this app to internet access"
        static let alertCancelAction: String = "Cancel"
        static let alertSettingsAction: String = "Settings"
        static let requestFilteredAlertTitle: String = "All your request is filtered"
        static let requestFilteredAlertMessage: String = "Please customize filters or change request"
    }
    
    enum Fonts {
        static let sFProTextSemiboldFont: String = "SFProText-Semibold"
        static let sFProTextRegularFont: String = "SFProText-Regular"
    }
    
    enum ImageNames {
        static let backButtonImageName: String = "chevron.backward"
        static let backButtonWebImageName: String = "arrowBack"
        static let forwardButtonImageName: String = "arrowForward"
        static let listButtonImageName: String = "listButton"
        static let addButtonImageName: String = "addButton"
        static let searchIconImageName: String = "searchIcon"
    }
    
    enum TableCellsId {
        static let filterWordsTableCellID: String = "filterWordsTableCellID"
    }
    
    enum ButtonsNames {
        static let titleButtonBack: String = "Back"
    }
    
    enum MainViewConstants {
        static let titleLabelText: String = "Website filter"
        static let textFieldPlaceHolderText: String = "Tap to search"
    }
    
    enum ListRestrictionsViewConstants {
        static let titleLabelText: String = "Current filters"
    }
    
    enum AddRestrictionViewConstants {
        static let titleLabelText: String = "Add filter"
        static let textFieldPlaceHolderText: String = "Input here words for filtering"
    }
}
