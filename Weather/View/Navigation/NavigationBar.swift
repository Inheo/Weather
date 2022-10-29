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
    @State var addNewPlaceAlertPresented = false
    @State var newCity: String = ""
    var height: CGFloat
    
    var addNewAddress: (String) -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: valueRelativeHeight(8)) {
                HStack {
                    dissmisButton
                    Spacer()
                    addNewPlaceButton
                }
                searchPlace
            }
        }
        .frame(height: height, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, topPadding)
        .backgroundBlur(radius: blurRadius, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .overlay {
            if addNewPlaceAlertPresented {
                AlertFindPlace(text: $newCity,
                               isPresented: $addNewPlaceAlertPresented,
                               title: "Write the name of the city") { placeName in
                    withAnimation {
                        addNewAddress(newCity)
                    }
                }
            }
        }
    }
    
    var dissmisButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                    .font(.system(size: chevronImageSize).weight(.medium))
                    .foregroundColor(.secondary)
                Text("Weather")
                    .font(.system(size: baseSize).weight(.regular))
                    .foregroundColor(.primary)
            }
            .frame(height: dismissButtonHeight)
        }
    }
    
    var addNewPlaceButton: some View {
        Button(action: { addNewPlaceAlertPresented = true }) {
            Image(systemName: "plus.circle")
                .font(.system(size: baseSize).weight(.regular))
        }
    }
    
    var searchPlace: some View {
        HStack(spacing: 2) {
            Image(systemName: "magnifyingglass")
            TextField("Search for a city", text: $searchText)
        }
        .foregroundColor(.secondary)
        .padding(.horizontal, 8)
        .padding(.vertical, valueRelativeHeight(10))
        .frame(height: searchHeight, alignment: .leading)
        .background(Color.bottomSheetBackground, in: baseShape)
        .innerShadow(shape: baseShape,
                     color: .black.opacity(0.25),
                     lineWidth: 2,
                     offsetY: 2,
                     blurRadius: 2)
    }
    
    // MARK: -
    let blurRadius: CGFloat = 20
    let topPadding = valueRelativeHeight(49)
    let chevronImageSize = valueRelativeHeight(24)
    let baseSize = valueRelativeHeight(28)
    let searchHeight = valueRelativeHeight(36)
    let dismissButtonHeight = valueRelativeHeight(44)
    let baseShape = RoundedRectangle(cornerRadius: 10)
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(searchText: .constant(""), height: 110, addNewAddress: {_ in })
    }
}
