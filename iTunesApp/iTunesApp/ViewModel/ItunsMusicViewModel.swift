//
//  ItunsMusicViewModel.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import Foundation

class ItunsMusicViewModel {
    var itunseResults: [ItunsListResult] = []
    
    func fetchMusic(search: String, media: String, completion: @escaping()-> Void) {
        let endPoint = MusicEndpoint.getAlbumList(search: search, media: media)
        Task {
            let result = await URLSessionNetworkClient().request(endPoint, modelObject: ItunsListModel.self, isCertificatePinning: true)
            switch result {
            case .success(let music):
                print(music.results)
                self.itunseResults = music.results
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
}
