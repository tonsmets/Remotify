# Remotify
Quick, easy and dirty Spotify control. Uses Mac OSX helper program and an iOS app.

## Explanation
I once wrote this solution because I needed a quick and easy way to control Spotify at a party we hosted at home. I only built the bare minimum because it worked for me. Add your own additions to make it more awesome and report back! I love to see some new functionality or to hear some great ideas.

Note that I am NOT responsible for malfunctioning of one of the two components. It was used once and I wrote it in an hour or so... Don't blame me if your party sucks because of the music :P

## Used libraries
To get an easy access to the Spotify controls in the host application I used [Tomek Wójcik's](https://github.com/tomekwojcik) awesome tiny command-line program [tune-control](http://tomekwojcik.github.io/tune-control/). It enabled me to interact with Spotify in a very easy way.

The host application server some kind of API that the iOS app uses. Is used [Robbie Hanson's](https://github.com/robbiehanson) library called [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer). I absolutely love the simplicity of this library. 

## Usage
I made a copy of the host app available [here for download](http://www.tonsmets.nl/downloads/Remotify-v1.0.0.dmg). It is signed using an old certificate I had from the iOS program I followed at school so ignore any warnings. If you don't trust the package you could also compile it yourself via XCode.

For non-developers the journey ends here... The iOS app is not available in the app store. It was built for one-time usage so I didn't feel the need to deploy it. If you are an iOS developer yourself you can compile and deploy the app to your phone yourself. 

## Example
