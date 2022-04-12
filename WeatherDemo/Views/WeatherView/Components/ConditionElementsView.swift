//
//  ConditionElementsView.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 10/04/2022.
//

import SwiftUI

struct ConditionElementsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: WeatherViewModel
    
    // MARK: - Init
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("\(viewModel.cloudCoverage) %")
                        .font(.subtitleS)
                }
                HStack {
                    Image("wind")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text(String(format: "%.1f", viewModel.windSpeed) + "m/s")
                        .font(.subtitleS)
                }
                HStack {
                    Image("humidity")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("\(viewModel.humidity) %").font(.subtitleS)
                }
            }
            .foregroundColor(viewModel.fontColor)
            //            Spacer()
        }//: HStack Conditions
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .padding(.bottom)
    }
}

// MARK: - Preview
struct ConditionElementsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionElementsView(viewModel: WeatherViewModel())
            .previewLayout(.sizeThatFits)
            .background(Color.black)
            .padding()
    }
}
