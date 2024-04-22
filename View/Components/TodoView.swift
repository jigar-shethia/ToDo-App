//
//  HomeView.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import SwiftUI
import StopWatch
import DataBase

struct TodoView: View {
    @StateObject var taskViewModel:TaskViewModel = TaskViewModelFactory.createTaskViewModel()
    @State private var selectedValue = TaskState.active
    @State private var showAddTaskView: Bool = false
    @State private var showTeskDetailView: Bool = false
    @State private var seletedTask: Task = Task()
    
    
    var body: some View {
        
        NavigationStack{
            Picker("Picker Fliter", selection: $selectedValue){
                ForEach(TaskState.allCases, id: \.self){
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedValue) { newValue in
                taskViewModel.getTask(isCompleted: selectedValue.rawValue == "Active")
            }
            
            List(taskViewModel.task){task in
                VStack(alignment: .leading) {
                    
                    Text(task.name)
                        .font(.title)
                    HStack {
                        Text(task.description)
                            .font(.subheadline)
                        Spacer()
                        Text(task.finishDate.toString())
                            .italic()
                            .font(.caption)
                    }
                    
                    
                } .onTapGesture {
                    seletedTask = task
                    showTeskDetailView.toggle()
                }
            } .onAppear{
                taskViewModel.getTask(isCompleted: true)
            }
            .navigationTitle("Home")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddTaskView.toggle()
                        } label: {
                            Image(systemName: "plus")
                            
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(taskViewModel: taskViewModel,showAddTaskView: $showAddTaskView)
            }
            .sheet(isPresented: $showTeskDetailView) {
                TaskDetailView(taskViewModel: taskViewModel, showTaskDetailView: $showTeskDetailView, selectedTask: $seletedTask)
            }
            .alert("Task Error", isPresented: $taskViewModel.showError, actions: {
                Button{
                    
                }label :{
                    Text("Ok")
                }
            }, message: {
                Text(taskViewModel.errorMessage)
            })
            
        }
        
        
    }


#Preview {
    TodoView()
}
