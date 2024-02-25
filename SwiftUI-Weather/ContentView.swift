//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Hanan Farizta on 24/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false;
    
    private let weatherData: [(dayOfWeek: String, imageName: String, temperature: Int)] = [
            ("TUE", "cloud.sun.fill", 74),
            ("WED", "cloud.sun.rain.fill", 65),
            ("THU", "wind.snow", 60),
            ("FRI", "cloud.heavyrain.fill", 55),
            ("SAT", "cloud.bolt.rain.fill", 50)
        ]
    
    var body: some View {
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20) {
                    ForEach(weatherData, id: \.dayOfWeek) { data in
                        WeatherDayView(
                            dayOfWeek: data.dayOfWeek, imageName: data.imageName,temperature: data.temperature)
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(
                        title: "Change Day Time", textColor: isNight ? .black : .blue, backgroundColor: .white
                    )
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
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            isNight ? .black : .blue,
            isNight ? .gray : Color("lightBlue")
        ]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
