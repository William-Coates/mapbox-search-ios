import Foundation
import CoreLocation

class SearchQuerySuggestionImpl: SearchQuerySuggestion, CoreResponseProvider {

    var originalResponse: CoreSearchResultResponse
    
    var id: String
    
    var name: String
    
    var address: Address?
    
    var descriptionText: String?
    
    var iconName: String?
    
    var suggestionType: SearchSuggestType
    
    var distance: CLLocationDistance?
    
    let batchResolveSupported: Bool
    
    init?(coreResult: CoreSearchResultProtocol, response: CoreSearchResponseProtocol) {
        assert(coreResult.center == nil)
        
        guard coreResult.resultTypes == [.query] else { return nil }
        
        self.id = coreResult.id
        self.suggestionType = .query
        self.name = coreResult.names[0]
        self.address = coreResult.addresses?.first.map(Address.init)
        self.iconName = nil // Queries should use it's special icon
        self.originalResponse = CoreSearchResultResponse(coreResult: coreResult, response: response)
        self.distance = coreResult.distanceToProximity
        self.batchResolveSupported = coreResult.action?.isMultiRetrievable ?? false
        
        self.descriptionText = coreResult.addressDescription
    }
}