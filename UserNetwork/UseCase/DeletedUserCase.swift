import Foundation

protocol DeletedUserCaseProtocol {
    func DeleteUserCase(id: Int) async throws
}

struct DeletedUserCase: DeletedUserCaseProtocol{

    var configuration : ConfigurarionNetworkProtocol
    
    init(configuration: ConfigurarionNetworkProtocol) {
        self.configuration = configuration
    }
    
    func DeleteUserCase(id: Int) async throws{
        try await configuration.deletedUser(id: id)
    }
    
}
