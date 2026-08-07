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
            Image(systemName: AppSystemIcon.magnifyingglass)
                .foregroundStyle(text.isEmpty ? .ypGray : .ypBlack)
            
            TextField(
                text: $text,
                prompt: Text("Введите запрос")
                    .foregroundStyle(.ypGray)) { }
                .focused($isFocused)
                .foregroundStyle(.ypBlack)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: AppSystemIcon.xmarkCircleFill)
                        .foregroundStyle(.ypGray)
                }
            }
        }
        .padding(AppSpacing.space8)
        .background(.textFieldBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.size10))
    }
}

#Preview {
    @Previewable @State var search = "12"
    @FocusState var isSearchFocused: Bool
    
    SearchField(text: $search, isFocused: $isSearchFocused)
}
