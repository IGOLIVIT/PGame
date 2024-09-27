//
//  NotesView.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI

struct NotesView: View {
    
    @StateObject var viewModel = NotesViewModel()
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                            
                        }
                    })
                    
                    Spacer()
                }
                .padding(.vertical, 6)
                
                Text("Recording and ideas")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 6)
                
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
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                    
                }, label: {
                    
                    Text("+ Add an entry")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))

                })
                
                if viewModel.records.isEmpty {
                    
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.records.filter{($0.recCat ?? "") == viewModel.currentCategory}, id: \.self) { index in
                            
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    Text(index.recTitle ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text(index.recDescr ?? "")
                                        .foregroundColor(.white.opacity(0.6))
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    HStack {
                                        
                                        HStack {
                                            
                                            Image(systemName: "calendar")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 17, weight: .regular))
                                            
                                            Text("\((index.recDate ?? Date()).convertDate(format: "dd.MM"))")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                        .padding(6)
                                        .padding(.horizontal, 5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                                        
                                        Spacer()

                                    }
                                    
                                    HStack {
                                        
                                        Text(index.recCat ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim")))
                                        
                                        Spacer()

                                    }
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            }
                        })
                    }
                }
                
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchRecords()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddNote(viewModel: viewModel)
        })
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
    }
}

#Preview {
    NotesView()
}
