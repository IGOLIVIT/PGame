//
//  ProjectsView.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI
import StoreKit

struct ProjectsView: View {
    
    @StateObject var viewModel = ProjectsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 9) {
                
                Text("Projects")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    HStack {
                        
                        Image("projects")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        
                        Text("Projects are always at hand!")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                    
                    VStack {
                        
                        Text("\(viewModel.progressActive)")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("Projects are active")
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding()
                    .frame(width: 100, height: 110)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                }
                
                HStack {
                    
                    NavigationLink(destination: {
                        
                        NotesView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image("notes")
                            .frame(width: 80, height: 40)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                    })
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSettings = true
                        }
                        
                    }, label: {
                        
                        Image("Settings")
                            .frame(width: 80, height: 40)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                    })
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Text("+ Add a project")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                    })
                }
                
                HStack {
                    
                    ForEach(viewModel.statuses, id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.currentStatus = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 22)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(viewModel.currentStatus == index ? 0.3 : 0)))
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.1)))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .semibold))
                        })
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(7)
                                    .padding(.horizontal, 6)
                                    .background(RoundedRectangle(cornerRadius: 7).fill(viewModel.currentCategory == index ? Color("prim") : Color.gray.opacity(0.2)))
                            })
                        }
                    }
                }
                
                if viewModel.tasks.isEmpty {
                    
                    VStack {
                        
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .semibold))
                        
                        Text("You haven't added any entries")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white.opacity(0.05)))
                    
                    Spacer()
                    
                } else {
                
                if viewModel.currentStatus == "In Progress" {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.tasks.filter{($0.taskCat ?? "") == viewModel.currentCategory}, id: \.self) { index in
                                
                                VStack(spacing: 10) {
                                    
                                    HStack {
                                        
                                        Text(index.taskTitle ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.taskCat ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim")))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Progress")
                                            .foregroundColor(.white.opacity(0.5))
                                            .font(.system(size: 14, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text("0/0")
                                            .foregroundColor(.white.opacity(0.5))
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white.opacity(0.05))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 5)
                                    
                                    HStack {
                                        
                                        HStack {
                                            
                                            Image(systemName: "calendar")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 17, weight: .regular))
                                            
                                            Text("\((index.taskDate ?? Date()).convertDate(format: "dd.MM.YYYY"))")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                        .padding(6)
                                        .padding(.horizontal, 5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            viewModel.selectedTask = index
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.isDetail = true
                                            }
                                            
                                        }, label: {
                                            
                                            HStack {
                                                
                                                Text("Details")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .medium))
                                                
                                                Image(systemName: "arrow.up.right")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .medium))
                                            }
                                        })
                                    }
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15.0).fill(Color("bg2")))
                            }
                        }
                    }
                    
                } else if viewModel.currentStatus == "Completed" {
                    
                    VStack {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .semibold))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else if viewModel.currentStatus == "On Pause" {
                    
                    VStack {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .semibold))
                    }
                    .frame(maxHeight: .infinity)
                    
                }
            }
                
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCat ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a category")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    Text("Create a new category for your projects and ideascomplete sentence.")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.category.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.category)
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
                        
                        viewModel.categories.append(viewModel.category)
                        
                        viewModel.category = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                            
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    })
                    .opacity(viewModel.category.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.category.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg4")))
                .padding()
                .offset(y: viewModel.isAddCat ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchTasks()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddTask(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            TaskDetail(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isSettings ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSettings = false
                        }
                    }
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white.opacity(0.1))
                        .frame(width: 40, height: 3)
                    
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    Button(action: {
                        
                        SKStoreReviewController.requestReview()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("Rate our app")
                                .foregroundColor(Color.white)
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                        }
                        .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.05)))
                    })
                    
                    Button(action: {
                        
                        guard let url = URL(string: "https://www.termsfeed.com/live/ae87df90-c32c-493a-84ec-68e39c29e6df") else { return }
                        
                        UIApplication.shared.open(url)
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "leaf.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("Usage Policy")
                                .foregroundColor(Color.white)
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                        }
                        .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.05)))
                    })
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg3")))
                .offset(y: viewModel.isSettings ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()

            }
        )
    }
}

#Preview {
    ProjectsView()
}
