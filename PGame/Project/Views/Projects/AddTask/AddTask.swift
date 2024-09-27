//
//  AddTask.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI

struct AddTask: View {
    
    @StateObject var viewModel: ProjectsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Add an entry")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        Text("Title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.taskTitle.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.taskTitle)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        
                        HStack {
                            
                            Text("Date")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            DatePicker("", selection: $viewModel.taskDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {

                                ForEach(viewModel.categories, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.categoryForAdd = index
                                        
                                    }, label: {
                                        
                                        Text(index)
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .medium))
                                            .padding(7)
                                            .padding(.horizontal, 6)
                                            .background(RoundedRectangle(cornerRadius: 7).fill(viewModel.categoryForAdd == index ? Color("prim") : Color.gray.opacity(0.2)))
                                    })
                                }
                            }
                        }
                        
                        LazyVStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddTask = true
                                }
                                
                            }, label: {
                                
                                Text("+ Add a task")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white.opacity(0.05)))

                            })
                            
                            ForEach(viewModel.notes.filter{($0.notTask ?? "") == viewModel.taskTitle}, id: \.self) { index in
                            
                                Text(index.notText ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))

                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white.opacity(0.05)))
                    }
                }
                
                Button(action: {
                    
                    viewModel.progressActive += 1
                    
                    viewModel.taskCat = viewModel.categoryForAdd
                    
                    viewModel.addTask()
                    
                    viewModel.taskTitle = ""
                    viewModel.categoryForAdd = ""
                    
                    viewModel.fetchTasks()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))

                })
                .opacity(viewModel.taskTitle.isEmpty ? 0.6 : 1)
                .disabled(viewModel.taskTitle.isEmpty ? true : false)
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddTask ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTask = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddTask = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a task")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()

                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.notText.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.notText)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .padding(1)
                    .padding(.bottom)
                    
                    Button(action: {
                                                
                        viewModel.notTask = viewModel.taskTitle
                        
                        viewModel.addNote()
                        
                        viewModel.notText = ""
                        
                        viewModel.fetchNotes()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTask = false
                            
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    })
                    .opacity(viewModel.notText.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.notText.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg4")))
                .padding()
                .offset(y: viewModel.isAddTask ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchNotes()
        }
    }
}

#Preview {
    AddTask(viewModel: ProjectsViewModel())
}
