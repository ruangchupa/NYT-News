//
//  EmptyView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

struct NoDataView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack() {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(text: "No Articles", image: Image(systemName: "newspaper"))
    }
}
