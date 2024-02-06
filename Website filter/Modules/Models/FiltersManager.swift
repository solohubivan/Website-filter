//
//  FiltersManager.swift
//  Website filter
//
//  Created by Ivan Solohub on 05.02.2024.
//

import Foundation

class FiltersManager {
    
    static let shared = FiltersManager()
    
    private var filters: [Filter] = []
    
    func addFilter(_ filter: Filter) {
        filters.append(filter)
    }
    
    func removeFilter(at index: Int) {
        guard index >= .zero, index < filters.count else { return }
        filters.remove(at: index)
    }
    
    func getActiveFilters() -> [Filter] {
        return filters
    }
    
    func getActiveFiltersCount() -> Int {
        return filters.count
    }
}
