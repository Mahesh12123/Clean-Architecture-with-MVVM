//
//  CleanArchitectureWithMvvmTests.swift
//  CleanArchitectureWithMvvmTests
//
//  Created by mahesh mahara on 12/02/2025.
//

import Testing
@testable import CleanArchitectureWithMvvm
import XCTest


//struct CleanArchitectureWithMvvmTests {
//
//    @Test func example() async throws {
//       // XCTAssertEqual
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }
//
//}


class CleanArchitectureWithMvvmTests: XCTestCase {
    
    func checkFirstNameandEmail(){
        
       let Sut = User(fullName: "mahesh", emil: "maheshEmail")
        XCTAssertEqual(Sut.fullNamewithEmail(), "mahesh ")
        
    }
    
    
    
    
}
