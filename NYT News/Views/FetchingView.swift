//
//  FetchingView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 13/01/22.
//

import SwiftUI

struct FetchingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            Text("Please wait").foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.black)
        .opacity(0.8)
    }
}

struct FetchingView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingView()
    }
}
