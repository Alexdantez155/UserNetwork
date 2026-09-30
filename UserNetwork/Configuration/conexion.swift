import Foundation

protocol ConfigurarionNetworkProtocol {
    func getUser() async throws -> [User]
    func aboutUser(id: Int) async  throws -> InfoUser
    func inserUser(data: UserPost) async throws -> UserPostResponse
    func deletedUser(id: Int) async throws
    func UpdateUser(user: UpdateUser, id: Int) async throws -> UserPostResponse
}


enum ErrorNetwork: Error {
    case invalidURL
    case serverError(Error)
}

final class ConfigurarionNetwork: ConfigurarionNetworkProtocol {
    
    static let shared = ConfigurarionNetwork()
    
    init(){
        
    }
    
    func getUser() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos")else{
            print("Not fund URL")
            throw ErrorNetwork.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let userDecoded = try JSONDecoder().decode([User].self, from: data)
            return userDecoded
        } catch {
            print(error.localizedDescription)
            throw ErrorNetwork.serverError(error)
        }
    }
    
    func aboutUser(id: Int) async  throws -> InfoUser {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")else{
            print("Not data")
            throw ErrorNetwork.invalidURL
        }
        do{
            let (data,_) =  try await URLSession.shared.data(from: url)
            let infoUserDecoded = try JSONDecoder().decode(InfoUser.self, from: data)
            return infoUserDecoded
        }catch{
            print(error.localizedDescription)
            throw ErrorNetwork.serverError(error)
        }
    }
    
    func inserUser(data: UserPost) async throws -> UserPostResponse {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")else{
            print("error in Post")
            throw ErrorNetwork.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let jsonEnconde = try JSONEncoder().encode(data)
            request.httpBody = jsonEnconde
            let (data, response) = try await URLSession.shared.data(for: request)
            if let responseHttp = response as? HTTPURLResponse {
                print("code: \(responseHttp)")
            }
            let responseDecoded = try JSONDecoder().decode(UserPostResponse.self,from: data)
            return responseDecoded
            
        } catch {
            print(error.localizedDescription)
            throw ErrorNetwork.serverError(error)
        }
        
    }
    
    func deletedUser(id: Int) async throws {
    
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")else {
            print("not fund url")
            throw ErrorNetwork.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let responseHttp = response as? HTTPURLResponse {
                print("code: \(responseHttp)")
            }
        } catch {
            print("error: \(error.localizedDescription)")
            throw ErrorNetwork.serverError(error)
        }
        
    }
    
    func UpdateUser(user: UpdateUser, id: Int) async throws -> UserPostResponse {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")else{
            print("not found url")
            throw ErrorNetwork.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encodeUser = try JSONEncoder().encode(user)
            request.httpBody = encodeUser
            let(data,reponse) = try await URLSession.shared.data(for: request)
            if let responseHttp = reponse as? HTTPURLResponse {
                print("code: \(responseHttp)")
            }
            let reponseDecoded = try JSONDecoder().decode(UserPostResponse.self, from: data)
            return reponseDecoded
        } catch {
            print(error.localizedDescription)
            throw ErrorNetwork.serverError(error)
        }
        
    }
    
    
    
}
