# Remotify
Quick, easy and dirty Spotify control. Uses Mac OSX helper program and an iOS app.

## Explanation
I once wrote this solution because I needed a quick and easy way to control Spotify at a party we hosted at home. I only built the bare minimum because it worked for me. Add your own additions to make it more awesome and report back! I love to see some new functionality or to hear some great ideas.

Note that I am NOT responsible for malfunctioning of one of the two components. It was used once and I wrote it in an hour or so... Don't blame me if your party sucks because of the music :P

## Used libraries
To get an easy access to the Spotify controls in the host application I used [Tomek Wójcik's](https://github.com/tomekwojcik) awesome tiny command-line program [tune-control](http://tomekwojcik.github.io/tune-control/). It enabled me to interact with Spotify in a very easy way.

The host application server some kind of API that the iOS app uses. Is used [Robbie Hanson's](https://github.com/robbiehanson) library called [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer). I absolutely love the simplicity of this library. 

## Usage
Connect your Mac running Spotify and your iOS device to the same network!!

First fire up Spotify, no need to play a song yet. Now fire up the host application. It may ask for the permission to access the internet. Allow this. The application shows some buttons and should also show the title of the song that is on pause or is playing in Spotify. At the bottom of the application it shows the IP-address your iOS app needs to connect to. You can click on the IP-address to fire up your browser and show some kind of documentation page explaining the "API".

Now fire up the iOS app on your phone and input the IP-address as shown in the host application. Also add the port! The app should automatically connect to the host. The app also shows the song info with the controls. Enjoy it!

## Getting it up and running
I made a copy of the host app available [here for download](http://www.tonsmets.nl/downloads/Remotify-v1.0.0.dmg). It is signed using an old certificate I had from the iOS program I followed at school so ignore any warnings. If you don't trust the package you could also compile it yourself via XCode.

For non-developers the journey ends here... The iOS app is not available in the app store. It was built for one-time usage so I didn't feel the need to deploy it. If you are an iOS developer yourself you can compile and deploy the app to your phone yourself. 

## Example
![schermafdruk 2015-03-02 19 16 30](https://cloud.githubusercontent.com/assets/6669915/6447523/67b0fa50-c113-11e4-8281-dc38c25fc9be.png)

![2015-03-02 19 16 23](https://cloud.githubusercontent.com/assets/6669915/6447535/8271295a-c113-11e4-9b86-ca2c04a47f94.png)
