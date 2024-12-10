//
//  MusicEndpoint.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import Foundation

enum MusicEndpoint {
    case getAlbumList(search: String, media: String)
}

extension MusicEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getAlbumList(let searchTerm, let media):
            return ["term":searchTerm,"media":media,"entity":"song, album, movie, podcast, audiobook"]
        }
        
    }
    
    var path: String {
        switch self {
        case .getAlbumList:
            return "/search"
            
        }
    }
}
