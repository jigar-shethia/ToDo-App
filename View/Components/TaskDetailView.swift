//
//  TaskDetailView.swift
//  ToDo App
//
//  Created by Jigar Shethia on 06/04/24.
//

import SwiftUI
import DataBase

struct TaskDetailView: View {
    @ObservedObject var taskViewModel :TaskViewModel
    @Binding var showTaskDetailView: Bool
    @Binding var selectedTask:Task
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
                           taskViewModel.deleteTask(task: selectedTask)
                        }label: {
                            Text("Delete")
                        }
                        
                        
                    } message: {
                        Text("Do you want Delete this task")
                    }
                    
                }
            }
            .onDisappear(perform: {
                taskViewModel.cancelSubcription()
            })
            .onReceive(taskViewModel.shouldDismiss, perform: { shouldDismiss in
                if(shouldDismiss){
                    showTaskDetailView.toggle()
                }
            })
            .alert("Task Error", isPresented: $taskViewModel.showError, actions: {
                Button{
                    
                }label :{
                    Text("Ok")
                }
            }, message: {
                Text(taskViewModel.errorMessage)
            })
            .navigationTitle("Task Details")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Add pressed")
                        taskViewModel.updateTask(task: selectedTask)
                        
                        
                    }label: {
                        Text("Update")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        print("Cancel Pressed")
                        showTaskDetailView.toggle()
                        
                    }label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(taskReposiory: TaskRepositoryImplementation()), showTaskDetailView: .constant(true), selectedTask: .constant(Task.createMockTask().first!))
}
