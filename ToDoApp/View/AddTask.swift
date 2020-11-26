//
//  AddTask.swift
//  ToDoApp
//
//  Created by addjn on 20/11/20.
//

import SwiftUI

struct AddTask: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State var taskTitle = ""
    @State var taskDesc = ""
    @State var prioritySelection = 0
    @State var isError = false
    private var taskPriorities = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("title", text: $taskTitle)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("PRIORITY")
                        .foregroundColor(Color(.systemGray))
                        .font(.caption)
                        .padding(.horizontal)
                    Picker("Priority", selection: $prioritySelection) {
                        ForEach(0..<taskPriorities.count) {
                            Text(taskPriorities[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                
                TextField("desc", text: $taskDesc)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                
                Button("Save") {
                    if taskTitle == "" || taskDesc == "" {
                        isError = true
                    } else {
                        let task = Task(context: self.moc)
                        task.id = UUID()
                        task.title = taskTitle
                        task.desc = taskDesc
                        task.priority = taskPriorities[prioritySelection]
                        task.priorityId = Int16(prioritySelection)
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Add Task", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                    }
            )
            .alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text("You've forgot something."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
