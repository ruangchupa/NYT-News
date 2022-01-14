//
//  String+Extensions.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import Foundation

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
