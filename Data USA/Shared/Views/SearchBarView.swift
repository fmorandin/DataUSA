//
//  SearchBarView.swift
//  Data USA
//
//  Created by Felipe Morandin on 13/10/2024.
//
import SwiftUI

struct SearchBarView: View {

    // MARK: - Public Variables

    var prompt: String
    var searchText: Binding<String>
    var isFocused: FocusState<Bool>.Binding

    // MARK: - UI

    var body: some View {
        HStack {
            TextField(prompt, text: searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top)
                .padding(.horizontal)
                .focused(isFocused)
        }
    }
}
