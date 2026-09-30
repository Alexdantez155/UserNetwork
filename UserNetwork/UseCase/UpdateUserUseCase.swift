import Foundation

protocol UpdateUserUseCaseProtocol {
    func UpdateUserCase(user: UpdateUser, id: Int) async throws -> UserPostResponse
}

struct UpdateUserUseCase: UpdateUserUseCaseProtocol {
    
    var configuration : ConfigurarionNetworkProtocol
    
    init(configuration: ConfigurarionNetworkProtocol) {
        self.configuration = configuration
    }
    
    func UpdateUserCase(user: UpdateUser, id: Int) async throws -> UserPostResponse {
       try await configuration.UpdateUser(user: user, id: id)
    }
    
}
