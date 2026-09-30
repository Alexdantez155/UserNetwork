import Foundation

struct InfoUser: Decodable, Identifiable{
    let userId :  Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
    }
}

struct User: Decodable, Identifiable {
    let userId :  Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case completed
    }
}

struct UserPost:  Encodable {
    let title: String
    let boby: String
    let userId: Int
}

struct UserPostResponse: Decodable {
    let id: Int
}

struct UpdateUser: Encodable {
    let id: Int
    let title: String
    let body : String
    let userId: Int
}

