import Foundation
import UIKit

struct AirQualityObj {
    init(aqi: Int) {
        self.aqi = aqi
        (self.status, self.description, self.color, self.imageString) = AirQualityObj.conditionName(aqi: self.aqi)
    }
    
    let aqi: Int
    let status: String
    let description: String
    let color: UIColor
    let imageString: String
    
    static func conditionName(aqi: Int) -> (String, String, UIColor, String)  {
        var index = -1
        switch aqi {
        case 0...50:
            index = 0
        case 51...100:
            index = 1
        case 101...150:
            index = 2
        case 151...200:
            index = 3
        case 201...300:
            index = 4
        default:
            index = 5
        }
        let status = NOTIFICATION_AIRQUALITY[index]["status"] as! String
        let description = NOTIFICATION_AIRQUALITY[index]["description"] as! String
        let color = NOTIFICATION_AIRQUALITY[index]["color"] as! UIColor
        let imageString = NOTIFICATION_AIRQUALITY[index]["image"] as! String
        return (status, description, color, imageString)
    }
}
