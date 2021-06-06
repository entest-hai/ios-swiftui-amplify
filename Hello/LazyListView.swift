//
//  LazyListView.swift
//  Hello
//
//  Created by hai on 03/06/2021.
//

import SwiftUI

struct SampleRow : View {
    let id: Int
    var body: some View {
        HStack {
            Text("Row \(id)")
                .padding(.horizontal)
            Spacer()
            Text("Hai")
                .padding(.horizontal)
        }
    }
    init(id: Int){
        print("create row \(id)")
        self.id = id
    }
}

struct LazyListView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...100, id: \.self){value in
                    SampleRow(id: value)
                }
            }
        }
    }
}


