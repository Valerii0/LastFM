//
//  TopArtistsRequestService.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class TopArtistsRequestService {
    static func getTopArtists(country: String, callBack: @escaping (_ topArtists: TopArtists?, _ error: Error?) -> Void) {
        let urlString = Api.url.rawValue
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "method", value: Api.getTopArtists.rawValue),
            URLQueryItem(name: "api_key", value: Api.api_key.rawValue),
            URLQueryItem(name: "format", value: Api.format.rawValue),
            URLQueryItem(name: "country", value: country)
        ]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let topArtists = try JSONDecoder().decode(TopArtists.self, from: data)
                    callBack(topArtists, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
    
    static func getTopAlbums(artistName: String, callBack: @escaping (_ topAlbums: TopAlbums?, _ error: Error?) -> Void) {
        let urlString = Api.url.rawValue
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "method", value: Api.getTopAlbums.rawValue),
            URLQueryItem(name: "api_key", value: Api.api_key.rawValue),
            URLQueryItem(name: "format", value: Api.format.rawValue),
            URLQueryItem(name: "artist", value: artistName)
        ]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let topAlbums = try JSONDecoder().decode(TopAlbums.self, from: data)
                    callBack(topAlbums, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
