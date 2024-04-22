//
//  AddTaskView.swift
//  ToDo App
//
//  Created by Jigar Shethia on 06/04/24.
//

import SwiftUI
import DataBase

struct AddTaskView: View {
    @ObservedObject var taskViewModel :TaskViewModel
    @State private var addTask: Task = Task()
    @Binding var showAddTaskView: Bool
    @State private var showAlert:Bool = false
    
    var pickerDateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let currentDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        let startingDateComponent = DateComponents(year: currentDateComponent.year,
                                                   month: currentDateComponent.month,
                                                   day: currentDateComponent.day,
                                                   hour: currentDateComponent.hour,
                                                   minute: currentDateComponent.minute)
        let endDateComponent = DateComponents(year: 2024,
                                              month: 12,
                                              day: 31,
                                              hour: currentDateComponent.hour,
                                              minute: currentDateComponent.minute)
        return calendar.date(from: startingDateComponent)! ... calendar.date(from: endDateComponent)!
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Task Details")) {
                    TextField("Task name", text: $addTask.name)
                    TextEditor(text: $addTask.description)
                }
                Section(header: Text("Task Date and Time")) {
                    DatePicker("Task Date", selection: $addTask.finishDate, in: pickerDateRange)
                }
            }
            .onDisappear(perform: {
                taskViewModel.cancelSubcription()
            })
            .onReceive(taskViewModel.shouldDismiss, perform: { shouldDismiss in
                if(shouldDismiss){
                    showAddTaskView.toggle()
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
            .navigationTitle("Add Task")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        addNewTask()
                    }label: {
                        Text("Add")
                    }.disabled(addTask.name.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        if(!addTask.name.isEmpty){
                            showAlert.toggle()
                        }else {
                            showAddTaskView.toggle()
                        }
                    }label: {
                        Text("Cancel")
                    }.alert("Save Task", isPresented: $showAlert) {
                        Button{
                            showAddTaskView.toggle()
                        }label: {
                            Text("Cancel")
                        }
                        Button{
                            addNewTask()
                        }label: {
                            Text("Save")
                        }
                    } message: {
                        Text("Would you like to save the task?")
                    }
                    
                }
            }
            
        }
    }
    private func addNewTask(){
        taskViewModel.addTask(task: addTask)
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(taskReposiory: TaskRepositoryImplementation()), showAddTaskView: .constant(false))
}
