//
//  ContentView.swift
//  xcconfigSample
//
//  Created by satorun on 2026/01/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("ApiHost: \(Const.apiHost)")
            Text("CommonString: \(Const.commonString)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
