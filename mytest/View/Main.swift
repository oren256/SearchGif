//
//  Main.swift
//  mytest
//
//  Created by  DNS on 13.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct Main: View {
    
    //получаем данные
    @State var gifData: [String] = []
    @State var present = false
    @State var url = ""
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            ForEach(gifData, id: \.self){url in
                HStack{
                    Spacer(minLength: 0)
                    
                    AnimatedImage(url:  URL(string: url)!)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(CustomShape())
                }
                .padding()
            }
            .onChange(of: url, perform: {value in
                self.gifData.append(value)
            })
            .navigationTitle("Giphy from Orenburg")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button(action: {present.toggle()}, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                })
            })
            
        })
        .fullScreenCover(isPresented: $present, content: {
            GiphyController(url: $url, present: $present)
        })
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
