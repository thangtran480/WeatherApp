import Foundation
import UIKit

let KEY_OPENWEATHERMAP = "27a7df37e78c33a32df2d5ac86d82ede"
let LANGUAGE = "vi"
let URL_OPENWEATHERMAP = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&appid=\(KEY_OPENWEATHERMAP)&lang=\(LANGUAGE)&units=metric"

let NOTIFICATION_AIRQUALITY = [
    ["status":"Tốt","description":"Chất lượng không khí được xem là đạt tiêu chuẩn, và ô nhiễm không khí coi như không hoặc gây rất ít nguy hiểm", "color": UIColor.green, "image": "air1"],
    ["status": "Trung bình", "description":"Chất lượng không khí ở mức chấp nhận được; tuy nhiên, một số chất gây ô nhiễm có thể ảnh hưởng tới sức khỏe của một số ít những người nhạy cảm với không khí bị ô nhiễm.", "color": UIColor.yellow, "image": "air2"],
    ["status" : "Không tốt", "description": "Nhóm người nhạy cảm có thể chịu ảnh hưởng sức khỏe. Số đông không có nguy cơ bị tác động.", "color": UIColor.orange, "image": "air3"],
    ["status" : "Ô nhiễm", "description": "Chất lượng không khí không lành mạnh, mọi người nên hạn chế ra ngoài", "color": UIColor.red, "image": "air4"],
    ["status" : "Rất ô nhiễm", "description": "Chất lượng không khí kém, cảnh báo nguy hại sức khỏe nghiêm trọng.", "color": UIColor.purple, "image": "air5"],
    ["status" : "Nguy hiểm", "description": "Cảnh báo về tình trạng khẩn cấp liên quan đến sức khỏe.", "color": UIColor.brown, "image": "air6"]
]
let KEY_AIRQUALITY = "f332e9e9acd321f105d83c280e17910ada820d33"
let URL_AIRQUALITY = "https://api.waqi.info/feed/%@/?token=\(KEY_AIRQUALITY)"
