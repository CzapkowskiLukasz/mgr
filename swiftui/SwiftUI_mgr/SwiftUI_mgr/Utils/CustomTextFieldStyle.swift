//
//  TextFieldStyle.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 21/01/2025.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    
    @State private var showPlaceholder: Bool = true
    
    var placeholder: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.leading, 12)
            .padding(.vertical, 8)
            .foregroundColor(.white.opacity(0.9))
            .font(.caption2)
            .accentColor(.white.opacity(0.8))
            .background(Color.background)
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(isFocused ? Color.blueMain : Color.clear, lineWidth: 3)
            )
            .focused($isFocused)
            .placeholder(when: $showPlaceholder, placeholder: placeholder)
            .onChange(of: text) { newValue in
                withAnimation {
                    showPlaceholder = newValue.count < 1
                }
            }
            .onChange(of: isFocused) { newValue in
                withAnimation {
                    showPlaceholder = text.count < 1
                }
            }
    }
}

extension View {
    func placeholder(
        when shouldShow: Binding<Bool>,
        alignment: Alignment = .leading,
        placeholder: String
    ) -> some View {
        ZStack(alignment: alignment) {
            self
            
            if shouldShow.wrappedValue {
                Text(placeholder)
                    .padding(.leading, 12)
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.caption2)
            }
            
        }
    }
}

