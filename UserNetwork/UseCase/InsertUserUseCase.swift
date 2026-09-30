import Foundation

protocol InsertUserUseCaseProtocol {
    func InsertUserCase(data: UserPost) async  throws -> UserPostResponse
}

struct InsertUserUseCase: InsertUserUseCaseProtocol {
    
    var configuration : ConfigurarionNetworkProtocol
    
    init(configuration: ConfigurarionNetworkProtocol) {
        self.configuration = configuration
    }
    func InsertUserCase(data: UserPost) async  throws -> UserPostResponse {
       return  try await configuration.inserUser(data: data)
    }
}
