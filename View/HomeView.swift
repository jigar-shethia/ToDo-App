//
//  HomeView.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel:TaskViewModel = TaskViewModel()
    @State var selectedValue = TaskState.active
    
    var body: some View {
        
        NavigationStack{
            Picker("Picker Fliter", selection: $selectedValue){
                ForEach(TaskState.allCases, id: \.self){
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedValue) { newValue in
                viewModel.getTask(isActive: selectedValue.rawValue == "Active")
            }
            
            List(viewModel.task){task in
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
                    
                    
                }
            }.onAppear{
                viewModel.getTask(isActive: true)
            }.navigationTitle("Home")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                        
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            
            
        }
        
        
    }
}

#Preview {
    HomeView()
}
