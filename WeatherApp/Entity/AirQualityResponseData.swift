import Foundation

struct AirQualityResponseData {
    let status: String
    let data: AirQualityObj
    
    init(json: NSDictionary) {
        self.status = ""
    }
    
}
