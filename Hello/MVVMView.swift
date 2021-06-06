//
//  MVVMView.swift
//  Hello
//
//  Created by hai on 06/06/2021.
//

import SwiftUI
import Foundation

struct User: Identifiable {
    let id: Int
    let name: String
}

protocol DataService {
    func getUsers(completion: @escaping ([User]) -> Void)
}

class AppDataService : DataService{
    func getUsers(completion: @escaping ([User]) -> Void){
        DispatchQueue.main.async {
            completion([
                User(id: 1, name: "Hai"),
                User(id: 2, name: "Min"),
                User(id: 3, name: "Tra")
            ])
        }
    }
}


struct UsersView: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.users){user in
            Text(user.name)
        }
        .onAppear(perform: viewModel.getUsers)
    }
}

extension UsersView {
    class ViewModel: ObservableObject {
        @Published var users = [User]()
        
        let dataservice: DataService
        
        init(dataservice: DataService = AppDataService()){
            self.dataservice = dataservice
        }
        
        func getUsers() {
            // TODO networking request backend and get users
            dataservice.getUsers{[weak self] users in
                self?.users = users
            }
        }
    }
}

struct MVVMView: View {
    
    var body: some View {
        UsersView()
    }
}


