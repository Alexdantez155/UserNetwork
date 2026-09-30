import Foundation
import Observation


@MainActor
@Observable
final class ViewModel {
    
    var users: [User] = []
    var infoUser: InfoUser?
    var userPost : UserPost?

    let getUserUseCase : GetUserUseCaseProtocol
    let aboutUserCase : AboutUserCaseProtocol
    let insertUserUseCase : InsertUserUseCaseProtocol
    let deletedUserCase : DeletedUserCaseProtocol
    let updateUserUseCase: UpdateUserUseCaseProtocol
    
    
    init() {
        getUserUseCase = GetUserUseCase(configuration: ConfigurarionNetwork.shared)
        aboutUserCase = AboutUserCase(configuration: ConfigurarionNetwork.shared)
        insertUserUseCase = InsertUserUseCase(configuration: ConfigurarionNetwork.shared)
        deletedUserCase = DeletedUserCase(configuration: ConfigurarionNetwork.shared)
        updateUserUseCase = UpdateUserUseCase(configuration: ConfigurarionNetwork.shared)
    }
    
    init(getUserUseCase : GetUserUseCaseProtocol,
         aboutUserCase :  AboutUserCaseProtocol,
         insertUserUseCase : InsertUserUseCaseProtocol,
         deletedUserCase : DeletedUserCaseProtocol,
         updateUserUseCase : UpdateUserUseCaseProtocol) {
        self.getUserUseCase = getUserUseCase
        self.aboutUserCase = aboutUserCase
        self.insertUserUseCase = insertUserUseCase
        self.deletedUserCase = deletedUserCase
        self.updateUserUseCase = updateUserUseCase
    }
    
    func getUser() async {
        do{
            users = try await getUserUseCase.getUserCase()
        } catch {
            print("Error al obtener usuarios: \(error.localizedDescription)")
        }
        
    }
    
    func aboutUser(id: Int) async -> InfoUser? {
        do {
            infoUser = try await aboutUserCase.AboutUserUseCase(id: id)
            return infoUser
        } catch {
            print("Error al obtener usuarios: \(error.localizedDescription)")
            fatalError()
        }
    }
    
    func inserUser(data: UserPost) async {
        do{
           let info = try await insertUserUseCase.InsertUserCase(data: data)
            print(info.id)
        } catch {
            print("Error al obtener usuarios: \(error.localizedDescription)")
        }
       
    }
    
    func deletedUser(id: Int) async {
        do {
            try await deletedUserCase.DeleteUserCase(id: id)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func UpdateUser(user: UpdateUser, id: Int) async {
        do{
          let info =  try await updateUserUseCase.UpdateUserCase(user: user, id: id)
            print(info)
        } catch {
            print("Error: \(error.localizedDescription)")

        }
        
    }
    
    
    
}



