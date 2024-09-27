//
//  AddNote.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI

struct AddNote: View {

    @StateObject var viewModel: NotesViewModel
    
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
                                .opacity(viewModel.recTitle.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.recTitle)
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
                            
                            DatePicker("", selection: $viewModel.recDate, displayedComponents: .date)
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

                        Text("Description")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.recDescr.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.recDescr)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                    }
                }
                
                Button(action: {
                    
                    viewModel.recCat = viewModel.categoryForAdd
                    
                    viewModel.addRecord()
                    
                    viewModel.recTitle = ""
                    viewModel.recDescr = ""
                    
                    viewModel.fetchRecords()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
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
                .opacity(viewModel.recTitle.isEmpty || viewModel.recDescr.isEmpty ? 0.6 : 1)
                .disabled(viewModel.recTitle.isEmpty || viewModel.recDescr.isEmpty ? true : false)
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchRecords()
        }
    }
}

#Preview {
    AddNote(viewModel: NotesViewModel())
}
