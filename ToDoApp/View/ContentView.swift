//
//  ContentView.swift
//  ToDoApp
//
//  Created by addjn on 20/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    @State var isAdd = false
    @State var low = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var filterHigh: [Task] {
        tasks.sorted(by: { $0.priorityId > $1.priorityId})
    }
    
    var filterLow: [Task] {
        tasks.sorted(by: { $0.priorityId < $1.priorityId})
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 20) {
//                    List {
                            ForEach(low ? filterLow : filterHigh) { task in
                                TaskItem(task: task)
                                    .contextMenu {
                                        Button("delete") {
                                            withAnimation {
                                                self.moc.delete(task)
                                                try? self.moc.save()
                                            }
                                        }
                                    }
                            }.onDelete(perform: removeT)
                        }
                    }
                    }
                .padding()
                    Spacer()
//                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isAdd = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .padding([.trailing, .bottom], 25)
                        }
                    }
                }
                
            }
            .onAppear {
                try? self.moc.save()
            }
            .navigationBarTitle("Tasks", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Menu {
                                        Text("Sort By")
                                        Button("Priority High") {
                                            self.low = false
                                        }

                                        Button("Priority Low") {
                                            self.low = true
                                        }
                                        
                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .imageScale(.large)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading)
                                        
                                    }
            )
            .sheet(isPresented: $isAdd) {
                AddTask()
            }
        }
    }
    func removeT(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
