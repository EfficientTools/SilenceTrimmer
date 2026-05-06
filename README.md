# SilenceTrimmer

### Removes "uh" and hesitations in your videos

> [!Note]
> Mini macOS SwiftUI app that lets you select a video, transcribe its audio locally to detect and list filler words like “uh”, “um”, etc., using Whisper (OpenAI) locally.

---

## Prerequisites

1. Install Python and local Whisper (small model):

```bash
brew install ffmpeg
pip install --upgrade pip
pip install git+https://github.com/openai/whisper.git
```

Make sure your Terminal’s Python environment is accessible by your app or adjust the script to use absolute paths if needed.

2. Copy the signing config template and fill in your [Apple Developer Team ID](https://developer.apple.com/account):

```bash
cp Config/Local.xcconfig.template Config/Local.xcconfig
# Edit Config/Local.xcconfig and set DEVELOPMENT_TEAM = <your-team-id>
```

3. Open the Xcode project `SilenceTrimmer.xcodeproj` or `.xcworkspace`
3. Add the `whisper_local.sh` script to the app bundle (Resources) - **Note: Only add it to the main SilenceTrimmer target, not the test targets**
4. Build and run the app on macOS 12+

## How it works
* Select a video (mp4, mov)
* Click “Start Processing”
* The app converts the video into WAV audio
* Transcribes locally with Whisper
* Displays occurrences of detected words like “uh”, “um”

## Author

[![Pierre-Henry Soria](https://avatars0.githubusercontent.com/u/1325411?s=200)](https://ph7.me "Pierre-Henry Soria, Software Developer")

Made with ❤️ by **[Pierre-Henry Soria](https://pierrehenry.be)**. A super passionate & enthusiastic Problem-Solver Engineer. Also, a true cheese 🧀, ristretto ☕️ and dark chocolate lover! 😋

[![@phenrysay](https://img.shields.io/badge/x-000000?style=for-the-badge&logo=x)](https://x.com/phenrysay "Follow Me on X")  [![pH-7](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/pH-7 "My GitHub")  [![YouTube Video](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtube.com/@pH7Programming "YouTube SucceedAI Video")  [![BlueSky](https://img.shields.io/badge/BlueSky-00A8E8?style=for-the-badge&logo=bluesky&logoColor=white)](https://bsky.app/profile/pierrehenry.dev "Follow Me on BlueSky")

## License

This **Silence Trimmer** is licensed under the [MIT License](LICENSE.md).
