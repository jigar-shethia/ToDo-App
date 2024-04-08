//
//  TaskDetailView.swift
//  ToDo App
//
//  Created by Jigar Shethia on 06/04/24.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var taskViewModel :TaskViewModel
    @Binding var showTeskDetailView: Bool
    @Binding var selectedTask:Task
    @Binding var refreshTaskList: Bool
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List{
                Section(header: Text("Task Details")) {
                    TextField("Task name", text: $selectedTask.name)
                    TextEditor(text: $selectedTask.description)
                    Toggle("Mark Completed", isOn: $selectedTask.isCompleted)
                }
                Section(header: Text("Task Date and Time")) {
                    DatePicker("Task Date", selection: $selectedTask.finishDate)
                
                }
                Section{
                    Button{
                        showDeleteAlert.toggle()
                        
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }.alert("Warning", isPresented: $showDeleteAlert) {
                        Button{
                            
                        }label: {
                            Text("Cancel")
                        } 
                        Button{
                            if (taskViewModel.deleteTask(task: selectedTask)){
                                
                                showTeskDetailView.toggle()
                                refreshTaskList.toggle()
                            }
                        }label: {
                            Text("Delete")
                        }
                        
                        
                    } message: {
                        Text("Do you want Delete this task")
                    }

                }
            }.navigationTitle("Task Details")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            print("Add pressed")
                            if (taskViewModel.updateTask(task: selectedTask)){
                                showTeskDetailView.toggle()
                                refreshTaskList.toggle()
                            }
                            
                        }label: {
                            Text("Update")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button{
                            print("Cancel Pressed")
                            showTeskDetailView.toggle()
                            
                        }label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(taskReposiory: TaskRepositoryImplementation()), showTeskDetailView: .constant(true), selectedTask: .constant(Task.createMockTask().first!), refreshTaskList: .constant(false))
}
