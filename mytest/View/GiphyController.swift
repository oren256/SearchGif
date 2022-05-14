//
//  GiphyController.swift
//  mytest
//
//  Created by  DNS on 13.05.2022.
//

import SwiftUI
import GiphyUISDK

struct GiphyController: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return GiphyController.Coordinator(parent: self)
    }
    
    
    @Binding var url: String
    @Binding var present: Bool
    
    func makeUIViewController(context: Context) -> GiphyViewController {
        Giphy.configure(apiKey: "pntHIWtvzLdR8APKnp3L8SuFavSwTIIg")
        let controller = GiphyViewController()
        controller.mediaTypeConfig = [.emoji, .gifs, .stickers]
        controller.delegate = context.coordinator
        GiphyViewController.trayHeightMultiplier = 1.05
        controller.theme = GPHTheme(type: .dark)
        
        return controller

    }
    
    func updateUIViewController(_ uiViewController: GiphyViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, GiphyDelegate {
        
        var parent: GiphyController
        
        init(parent: GiphyController){
            self.parent = parent
        }
        
        func didDismiss(controller: GiphyViewController?) {
            
        }
        
        func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
            
            let url = media.url(rendition: .fixedWidth, fileType: .gif)
            parent.url = url ?? ""
            parent.present.toggle()
        }
    }
}
