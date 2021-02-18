//
//  EbayErrors.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation

// MARK: - EbayError
struct EbayError: Error, Equatable {
    enum ErrorKind {
        case dataNotDecodable
        case serverError
        case invalidURL
        case noMoreDataAvailable
        case canNotLoadWebView
        case notConnectedToInterNet
    }
    let kind: ErrorKind
    let message: String
}


// MARK: - Errors
/// `LocalErrors` is a struct that has defination of errors used by enum `Errors`
struct LocalErrors {
    static let dataNotDecodable = EbayError(kind: .dataNotDecodable, message: "Can not Read Data from file")
    static let serverError = EbayError(kind: .serverError, message: "We are having problem with server, we will get back soon.")
    static let inValidUrlType = EbayError(kind: .invalidURL, message: "Cannot find data due to invalid URL type")
    static let noMoreDataAvailable = EbayError(kind: .noMoreDataAvailable, message: "No more data available")
    static let canNotLoadWebView = EbayError(kind: .canNotLoadWebView, message: "Something went wrong while loading webview")
    static let notConnectedToInterNet = EbayError(kind: .canNotLoadWebView, message: "Please connect to Internet")

}
