//
//  FailureView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

struct FailureView: View {
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
            Button(action: retryAction) {
                Text("Try again")
            }
        }
    }
}

struct FailureView_Previews: PreviewProvider {
    static var previews: some View {
        FailureView(text: "Data is not available.") {
            
        }
    }
}
