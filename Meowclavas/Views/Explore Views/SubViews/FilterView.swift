//
//  FilterView.swift
//  Meowclavas
//
//  Created by Imran on 27.01.22.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var modelData: ModelData
    
    // slider state variables
    @State private var minPrice: Double = 0.0
    @State private var maxPrice: Double = 100.0
    @State private var minIsEditing: Bool = false
    @State private var maxIsEditing: Bool = false

    // filter options - products
    @State private var filterProductOptions: [FilterOptions] =
    [
        FilterOptions(name: "Balaclava", isSelected: false),
        FilterOptions(name: "Hat", isSelected: false),
        FilterOptions(name: "Scarf", isSelected: false),
        FilterOptions(name: "Jacket", isSelected: false),
        FilterOptions(name: "Poncho", isSelected: false),
        FilterOptions(name: "Bag", isSelected: false)
    ]

    var body: some View {
        NavigationView {
            VStack {
                // MIN PRiCE
                Group {
                    // min price label
                    HStack {
                        Text("Min price")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding([.top,.horizontal])
                    .onAppear() {
                        self.minPrice = modelData.filter.minPrice
                    }
                    
                    // max price slider
                    Slider(
                        value: $minPrice,
                        in: 0...maxPrice,
                        step: 5
                    ) {
                        Text("Min Price")
                    } minimumValueLabel: {
                        Text("₼ 0")
                    } maximumValueLabel: {
                        Text("₼ \(String(format: "%.0f", maxPrice))")
                    } onEditingChanged: { editing in
                        minIsEditing = editing
                    }
                    .padding(.horizontal)
                    
                    Text("₼ " + String(format: "%.2f", minPrice))
                            .foregroundColor(minIsEditing ? .blue : .primary)
                }
                
                // MAX PRICE
                Group {
                    // max price label
                    HStack {
                        Text("Max price")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding([.top,.horizontal])
                    .onAppear() {
                        self.maxPrice = modelData.filter.maxPrice
                    }
                    
                    // max price slider
                    Slider(
                        value: $maxPrice,
                        in: minPrice...100,
                        step: 5
                    ) {
                        Text("Max Price")
                    } minimumValueLabel: {
                        Text("₼ \(String(format: "%.0f", minPrice))")
                    } maximumValueLabel: {
                        Text("₼ 100")
                    } onEditingChanged: { editing in
                        maxIsEditing = editing
                    }
                    .padding(.horizontal)
                    
                    Text("₼ " + String(format: "%.2f", maxPrice))
                            .foregroundColor(maxIsEditing ? .blue : .primary)
                }
                
                // max price label
                HStack {
                    Text("Products")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button("Select All") {
                        for index in filterProductOptions.indices {
                            filterProductOptions[index].isSelected = true
                        }
                    }
                    .foregroundColor(.gray)
                }
                .padding([.top,.horizontal])
                .onAppear() {
                    for index in filterProductOptions.indices {
                        if modelData.filter.options.contains(filterProductOptions[index].name) {
                            filterProductOptions[index].isSelected = true
                        }
                    }
                }
                
                List {
                    ForEach(filterProductOptions.indices, id: \.self) { index in
                        HStack {
                            Text(filterProductOptions[index].name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(filterProductOptions[index].isSelected ? Color.blue : Color.gray)
        
                            Spacer()
        
                        
                            Button() {
                                filterProductOptions[index].isSelected.toggle()
                            } label: {
                                if filterProductOptions[index].isSelected {
                                    Image(systemName: "checkmark")
                                }
                            }
                            
                        }
                        .padding(.vertical, 10)
                    }
                }
                .padding(.vertical)
                .listStyle(.inset)
                
                Button(action: {
                    modelData.filter.minPrice = minPrice
                    modelData.filter.maxPrice = maxPrice
                    
                    for filterOption in filterProductOptions {
                        if filterOption.isSelected {
                            modelData.filter.options.insert(filterOption.name)
                        } else {
                            modelData.filter.options.remove(filterOption.name)
                        }
                    }
                }) {
                    HStack {
                        Text("Apply")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(.primary)
                .cornerRadius(24)
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Filters")
            .toolbar {
                Button {
                    minPrice = 0.0
                    maxPrice = 100.0
                    for index in filterProductOptions.indices {
                        filterProductOptions[index].isSelected = false
                    }
                    
                    modelData.filter = Filter(minPrice: minPrice, maxPrice: maxPrice, options: [])
                } label: {
                    Text("Clear")
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(ModelData())
    }
}
