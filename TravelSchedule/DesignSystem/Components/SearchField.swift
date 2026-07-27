//
//  SearchField.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Введите запрос", text: $text)
                .focused($isFocused)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.ypGray)
                }
            }
        }
        .padding(AppSpacing.space8)
        .background(.ypLightGray)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.size10))
    }
}

#Preview {
    @Previewable @State var search = "12"
    @FocusState var isSearchFocused: Bool
    
    SearchField(text: $search, isFocused: $isSearchFocused)
}
