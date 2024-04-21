//
//  GeneralView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/12/24.
//

import SwiftUI

struct GeneralView: View {
    var vegetable: Vegetable
    var body: some View {
        VStack(alignment: .leading) {
            FullWidthTextView(imageName: "general", text: "Varieties", value: vegetable.varieties, imageWidth: 45)
            HStack {
                Image("tips")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)

                Text("Tips and Tricks")
                    .font(Font.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.horizontal, 10)
            ForEach(vegetable.tipsAndTricks, id:  \.self) { tip in
                HStack {
                    Image("lightbulb")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text(tip)
                        .font(Font.custom("AmericanTypewriter", size: 15))
                        .fontWeight(.regular)
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 1)
                .padding(.leading)
            }
            
            HStack {
                Image("additionalResources")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)

                Text("Additional Resources")
                    .font(Font.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.horizontal, 10)
            ForEach(vegetable.linksToAdditionalResources, id:  \.self) { resource in
                HStack {
                    Image("text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    VStack(alignment: .leading) {
                        Link(resource.title, destination: URL(string: resource.url)!)
                            .font(Font.custom("AmericanTypewriter", size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 10)
                        Text(resource.url)
                            .font(Font.custom("AmericanTypewriter", size: 13))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                    }
                    
                    
                }
                .padding(.vertical, 1)
                .padding(.leading)
            }

        }
    
        .padding(.top, 30)
        .foregroundColor(.black)
    }
}

struct GeneralView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        GeneralView(vegetable: data.vegetables[4])
    }
}
