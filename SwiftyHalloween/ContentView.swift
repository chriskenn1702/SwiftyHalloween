//
//  ContentView.swift
//  SwiftyHalloween
//
//  Created by Christopher Kennedy on 3/19/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var imageName = ""
    @State private var soundName = ""
    @State private var message = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var imageNames = ["corona", "bat", "ghost", "spider", "vampire", "witch", "pumpkin", "skull", "david", "house"]
    @State private var messages = ["It is certain",
                                  "It is decidedly so",
                                  "Without a doubt",
                                  "Yes, definitely",
                                  "You may rely on it",
                                  "As I see it, yes",
                                  "Most likely",
                                  "Outlook good",
                                  "Yes",
                                  "Signs point to yes",
                                  "Reply hazy try again",
                                  "Ask again later",
                                  "Better not tell you now",
                                  "Cannot predict now",
                                  "Concentrate and ask again",
                                  "Don't count on it",
                                  "My reply is no",
                                  "My sources say no",
                                  "Outlook not so good",
                                  "Very doubtful"]
    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .animation(.default, value: imageName)
            Spacer()
            Text(message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 80)
                .animation(.default, value: message)
            Spacer()
            Button("🎃 Predict"){
                var newImage = imageNames.randomElement()
                while newImage == imageName{
                    newImage = imageNames.randomElement()
                }
                imageName = newImage!
                soundName = newImage! + "_sound"
                playSound(soundName: soundName)
                var newMessage = messages.randomElement()
                while newMessage == message{
                    newMessage = messages.randomElement()
                }
                message = newMessage!
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.black)
            .font(.title)
        }
        .padding()
    }
    func playSound(soundName: String){
        guard let soundFile = NSDataAsset(name: soundName) else{
            print("😧 Could not read file named \(soundName)")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch{
            print("🤬 ERROR: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
