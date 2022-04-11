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
    
    @Binding var selectedLocation: String
    @Binding var selectedCountry: String
    @State var searchText: String = ""
    @State private var isEditing = false
    
    // MARK: - Init
    init(selectedLocation: Binding<String>, selectedCountry: Binding<String>) {
        self._selectedLocation = selectedLocation
        self._selectedCountry = selectedCountry
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.weather.rain)
        UITableView.appearance().backgroundColor = .clear
    }
    
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
                        HStack {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                            
                            Text("Back")
                        }//: HStack
                    })//: Button
                    
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
                    .background(Color.weather.rain)
                    .foregroundColor(Color.weather.mist)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                }//: Searchbar
                .overlay(
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
                    }
                        .padding(.horizontal, 7)
                )//: Searchbar overlay
                
                Spacer()
                
                List(viewModel.result, id: \.country) { result in
                    HStack {
                        Text(result.name)
                        Text(result.country)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedLocation = result.name
                        selectedCountry = result.country
                        dismiss()
                    }//: Tap Gesture
                }//: Result List
            }//: VStack
        }//: Top ZStack
        .background(Color.weather.snow)
    }
}

// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedLocation: .constant("London"),
                   selectedCountry: .constant("GB"))
    }
}
