//
//  InfiniteScrollView.swift
//  Hello
//
//  Created by hai on 03/06/2021.
//

import SwiftUI

struct InfiniteScrollView: View {
    @ObservedObject var sot = SourceOfTruth()
    @State var nextIndex = 1
    
    init() {
        sot.getAnimals(at: 0)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(sot.animals.indices, id: \.self){animalIndex in
                        let animal = self.sot.animals[animalIndex]
                        Text("\(animal.emoji) \(animal.name)")
                            .padding(.vertical, 30)
                            .onAppear{
                                if animalIndex == sot.animals.count - 2 {
                                    self.sot.getAnimals(at: nextIndex)
                                    nextIndex += 1
                                }
                            }
                    }
                }
            }
            .navigationTitle("Animals")
        }
    }
}


class SourceOfTruth: ObservableObject {
    @Published var animals = [Animal]()
    
    func getAnimals(at index: Int){
        
        print("getting data ", index)
        
        switch index {
        case 0:
            animals.append(contentsOf: [
                Animal(id: 1, emoji: "🐶", name: "Dog"),
                Animal(id: 2, emoji: "🐱", name: "Cat"),
                Animal(id: 3, emoji: "🐭", name: "Mouse"),
                Animal(id: 4, emoji: "🐹", name: "Hamster"),
                Animal(id: 5, emoji: "🐰", name: "Rabbit"),
                Animal(id: 6, emoji: "🦊", name: "Fox"),
                Animal(id: 7, emoji: "🐻", name: "Bear"),
                Animal(id: 8, emoji: "🐼", name: "Panda"),
                Animal(id: 9, emoji: "🐻‍❄️", name: "Polar Bear"),
                Animal(id: 10, emoji: "🐨", name: "Koala"),
                Animal(id: 11, emoji: "🐯", name: "Tiger"),
                Animal(id: 12, emoji: "🦁", name: "Lion"),
                Animal(id: 13, emoji: "🐮", name: "Cow"),
                Animal(id: 14, emoji: "🐷", name: "Pig"),
                Animal(id: 15, emoji: "🐸", name: "Frog")
            ])
        case 1:
            animals.append(contentsOf: [
                Animal(id: 16, emoji: "🐵", name: "Monkey"),
                Animal(id: 17, emoji: "🐔", name: "Chicken"),
                Animal(id: 18, emoji: "🐧", name: "Penguin"),
                Animal(id: 19, emoji: "🐦", name: "Bird"),
                Animal(id: 20, emoji: "🐤", name: "Chick"),
                Animal(id: 21, emoji: "🦆", name: "Duck"),
                Animal(id: 22, emoji: "🦅", name: "Eagle"),
                Animal(id: 23, emoji: "🦉", name: "Owl"),
                Animal(id: 24, emoji: "🦇", name: "Bat"),
                Animal(id: 25, emoji: "🐺", name: "Wolf"),
                Animal(id: 26, emoji: "🐗", name: "Boar"),
                Animal(id: 27, emoji: "🐴", name: "Horse"),
                Animal(id: 28, emoji: "🦄", name: "Unicorn"),
                Animal(id: 29, emoji: "🐝", name: "Bee"),
                Animal(id: 30, emoji: "🐛", name: "Bug")
            ])
        default:
            break;
        }
    }
}

struct Animal: Identifiable {
    let id: Int
    let emoji: String
    let name: String
}

