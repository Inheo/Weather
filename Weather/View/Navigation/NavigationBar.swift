//
//  NavigationBar.swift
//  Weather
//
//  Created by Даниял on 21.10.2022.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    @State var addNewCityAlertPresented = false
    @State var newCity: String = ""
    
    var addNewAddress: (String) -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24).weight(.medium))
                                .foregroundColor(.secondary)
                            Text("Weather")
                                .font(.system(size: 28).weight(.regular))
                                .foregroundColor(.primary)
                        }
                        .frame(height: 44)
                    }
                    
                    Spacer()
                    Button(action: { addNewCityAlertPresented = true }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 28).weight(.regular))
                    }
                    .alert("Search new city", isPresented: $addNewCityAlertPresented) {
                        TextField("Search city", text: $newCity)
                            .foregroundColor(Color.black)
                        Button("Add", action: {
                            withAnimation {
                                addNewAddress(newCity)
                                newCity = ""
                            }
                            
                        })
                        Button("Cancel", action: { newCity = "" })
                    }
                }
                
                HStack(spacing: 2) {
                    Image(systemName: "magnifyingglass")
                    TextField("Search for a city or airport", text: $searchText)
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .frame(height: 36, alignment: .leading)
                .background(Color.bottomSheetBackground, in: RoundedRectangle(cornerRadius: 10))
                .innerShadow(shape: RoundedRectangle(cornerRadius: 10),
                             color: .black.opacity(0.25),
                             lineWidth: 2,
                             offsetY: 2,
                             blurRadius: 2)
            }
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(searchText: .constant(""), addNewAddress: {_ in })
    }
}
