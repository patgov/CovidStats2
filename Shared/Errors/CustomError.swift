//
//  CustomError.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.



import Foundation

// conforms to Error protocol
enum CovidError: Error {
case incorrectURL, noDataReceived
}
