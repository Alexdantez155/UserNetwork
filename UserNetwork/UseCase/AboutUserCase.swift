import Foundation

protocol AboutUserCaseProtocol {
    func AboutUserUseCase(id: Int)async throws -> InfoUser
}

struct AboutUserCase: AboutUserCaseProtocol{
    
    var configuration: ConfigurarionNetworkProtocol
    
    init(configuration: ConfigurarionNetworkProtocol) {
        self.configuration = configuration
    }
    
    func AboutUserUseCase(id: Int)async throws -> InfoUser {
       return  try await configuration.aboutUser(id: id)
    }
    
}
