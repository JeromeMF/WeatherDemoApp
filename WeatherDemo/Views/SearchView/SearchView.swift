//
//  SearchView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    @Binding var selectedResult: String
    @State var searchText: String = ""
    
    @State var selectKeeper: String? = nil
    
    @State private var isEditing = false
    
    
    // MARK: - Body
    var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    Image("landscape1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black.opacity(0.03))
                }
                
                VStack(){
                    
                    HStack(alignment: .top, spacing: 0) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        })
                        
                        Spacer()
                        
                    } //: HStack Header
                    .foregroundColor(Color.weather.rain)
                    .padding()
                    
                    HStack {
                        TextField("Search location...", text: $searchText, onCommit: {
                            viewModel.clearResult()
                            viewModel.searchLocations(searchText)
                        })
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.isEditing = true
                            }
                    }.overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                            if isEditing {
                                Button(action: {
                                    self.searchText = ""
                                    viewModel.clearResult()
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }.padding(.horizontal, 7)
                    )
                    
                    Spacer()
                    
                    List(viewModel.result, id: \.country, selection: $selectKeeper) { result in
                        HStack {
                            Text(result.name)
                            Text(result.country)
                        }.onTapGesture {
                            print(result.name)
                            print(result.country)
                        }
                    }
                }
            }
        }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedResult: .constant("test"))
    }
}
