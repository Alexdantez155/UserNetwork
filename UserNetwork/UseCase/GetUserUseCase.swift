import Foundation

protocol GetUserUseCaseProtocol {
    func getUserCase() async throws -> [User]
}


struct GetUserUseCase: GetUserUseCaseProtocol {
    
    let configuration : ConfigurarionNetworkProtocol
    
    init(configuration: ConfigurarionNetworkProtocol) {
        self.configuration = configuration
    }
    
    func getUserCase() async throws -> [User]{
       return try await configuration.getUser()
    }
    
}
