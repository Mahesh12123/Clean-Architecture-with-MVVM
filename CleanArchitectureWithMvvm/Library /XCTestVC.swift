//
//  XCTestVC.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 29/07/2025.
//

import Foundation

class User{
    
    private let fullName:String
    private  let emil:String
    
    init(fullName: String, emil: String) {
        self.fullName = fullName
        self.emil = emil
    }
    
    func fullNamewithEmail() -> String {
        
        return fullName + emil
        
    }
    
}
