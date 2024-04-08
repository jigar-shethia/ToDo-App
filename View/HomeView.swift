//
//  HomeView.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskViewModel:TaskViewModel = TaskViewModelFactory.createTaskViewModel()
    @State private var selectedValue = TaskState.active
    @State private var showAddTaskView: Bool = false
    @State private var showTeskDetailView: Bool = false
    @State private var seletedTask: Task = Task()
    @State private var refreshTaskList: Bool = true
    
    
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
            .onChange(of: refreshTaskList, {
                taskViewModel.getTask(isCompleted: selectedValue.rawValue == "Active")
            })
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
                .sheet(isPresented: $showAddTaskView) {
                    AddTaskView(taskViewModel: taskViewModel,showAddTaskView: $showAddTaskView, refreshTaskList: $refreshTaskList)
                }
                .sheet(isPresented: $showTeskDetailView) {
                    TaskDetailView(taskViewModel: taskViewModel, showTeskDetailView: $showTeskDetailView, selectedTask: $seletedTask, refreshTaskList: $refreshTaskList)
                }
            
            
        }
        
        
    }
}

#Preview {
    HomeView()
}
