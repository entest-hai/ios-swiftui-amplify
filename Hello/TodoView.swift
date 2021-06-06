//
//  TodoView.swift
//  Hello
//
//  Created by hai on 06/06/2021.
//

import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var body: String
    
    init (body: String) {
        self.body = body
    }
}

extension Todo: Equatable {
    public static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id && lhs.body == rhs.body
    }
}

class SourceOfTruthTodo: ObservableObject {
    // TODO Amplify DataStore or API to persist data to AWS DDB 
    @Published var todos = [Todo]()
    
    func getTodos(){
        self.todos.append(contentsOf: [
            Todo(body: "Cook breakfast"),
            Todo(body: "Have launch"),
            Todo(body: "Have dinner")
        ])
    }
    
    func deleteTodo(at indexSet: IndexSet) {
        self.todos.remove(atOffsets: indexSet)
    }
    
    func saveTodo(body content: String) {
        self.todos.append(Todo(body: content))
    }
}

struct NewTodoView : View {
    let sot: SourceOfTruthTodo
    @State var text = String()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Enter a new Todo")
                .font(.largeTitle)
            
            TextEditor(text: $text)
                .padding(.horizontal)
            
            Button(action: {
                self.sot.saveTodo(body: text)
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            )
            
            Spacer()
                .frame(height: 30)
        }
    }
}


struct TodoView: View {
    
    @ObservedObject var sot = SourceOfTruthTodo()
    @State var showNewTodo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.sot.todos){todo in
                        Text(todo.body)
                    }
                    .onDelete(perform: { indexSet in
                        self.sot.deleteTodo(at: indexSet)
                    })
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        showNewTodo.toggle()
                    },
                           label: {
                            Image(systemName: "plus")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .clipShape(Circle())
                           }
                    )
                    Spacer()
                        .frame(height: 30)
                }
            }
            .navigationTitle("Todo")
            .sheet(isPresented: $showNewTodo, content: {
                NewTodoView(sot: self.sot)
            })
        }
        .onAppear(){
            self.sot.getTodos()
        }
    }
}


