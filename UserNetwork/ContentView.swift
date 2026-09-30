import SwiftUI

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack{
            List(viewModel.users){ user in
                Text(user.title)
                    .swipeActions{
                        Button(action: {
                            Task{
                                if let data = await viewModel.aboutUser(id: user.id){
                                    print(data)
                                }
                            }
                        }, label: {
                            Label("Info", systemImage: "info.square.fill")
                                .tint(.blue)
                        })
                        Button(action: {
                            Task{
                               await viewModel.deletedUser(id: user.id)
                            }
                        }, label: {
                            Label("Eliminar", systemImage: "trash").tint(.red)
                        })
                        Button(action: {
                            let updateUser = UpdateUser(id: 99, title: "strings", body: "this body", userId: 99)
                            Task{
                                await viewModel.UpdateUser(user: updateUser, id: user.id)
                            }
                        }, label: {
                            Label("Modificar", systemImage: "pencil.line").tint(.orange)
                        })
                    }
            }
            .navigationTitle("UserNetwork")
            .toolbar{
                ToolbarItem{
                    Button(action: {
                        let userPost = UserPost(title: "Juan", boby: "nuevo trabajador", userId: 99)
                        Task{
                            await viewModel.inserUser(data: userPost)
                        }
                    }, label: {
                        Label("Add", systemImage: "plus")
                    })
                }
            }
            .task  {
                await viewModel.getUser()
            }
        }
    }
}

#Preview {
    ContentView()
}
