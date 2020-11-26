//
//  TaskItem.swift
//  ToDoApp
//
//  Created by addjn on 20/11/20.
//

import SwiftUI

struct TaskItem: View {
    var task: Task
    var body: some View {
        VStack {
            HStack {
            Text(task.title!)
                .font(.headline)
                .bold()
                Spacer()
                switch task.priority {
                case "High":
                    Image(systemName: "circle.fill")
                        .foregroundColor(.red)
                case "Medium":
                    Image(systemName: "circle.fill")
                        .foregroundColor(.yellow)
                case "Low":
                    Image(systemName: "circle.fill")
                        .foregroundColor(.blue)
                default :
                    Image(systemName: "circle.fill")
                        .foregroundColor(.clear)
                    
                }
                
            }
            HStack {
            Text(task.desc!)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .foregroundColor(Color("c"))
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(13)
    }
}


