import Foundation

struct DataResponse : Codable{
    let radios: [Radio]
}
struct Radio:Codable {
    var name : String
    let radio_url : String
}

