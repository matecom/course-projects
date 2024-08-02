//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Mateusz Bereta on 01/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                MainWeatherStatusView(icon: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                HStack (spacing: 20) {
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                }
                Spacer()
                
                Button {
                    print("Tapped")
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    var body: some View {
        VStack {
            Text(dayOfWeek).font(.system(size: 16, weight: .medium)).foregroundColor(.white)
            Image(systemName: imageName).symbolRenderingMode(.multicolor).resizable().aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
            Text("\(temperature)°").font(.system(size: 28, weight: .medium)).foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: isNight ? [.black, .gray] : [.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName).font(.system(size: 32, weight: .medium)).foregroundColor(.white).padding()
    }
}

struct MainWeatherStatusView: View {
    var icon: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Image(systemName: icon).renderingMode(.original).resizable().aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°").font(.system(size: 70, weight: .medium)).foregroundColor(.white)
        }.padding(.bottom, 40)
    }
}


