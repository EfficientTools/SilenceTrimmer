import SwiftUI

struct ContentView: View {
    @State private var videoURL: URL?
    @State private var isProcessing = false
    @State private var outputText = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Silence & 'Euh' Trimmer").font(.title).bold()

            Button("Sélectionner une vidéo") {
                let panel = NSOpenPanel()
                panel.allowedFileTypes = ["mp4", "mov"]
                panel.begin { response in
                    if response == .OK {
                        self.videoURL = panel.url
                    }
                }
            }

            if let url = videoURL {
                Text("Vidéo sélectionnée : \(url.lastPathComponent)")
                    .font(.caption)
            }

            Button("Lancer le traitement") {
                guard let url = videoURL else { return }
                isProcessing = true
                outputText = "Traitement en cours..."

                DispatchQueue.global().async {
                    let result = processVideo(url: url)
                    DispatchQueue.main.async {
                        outputText = result
                        isProcessing = false
                    }
                }
            }
            .disabled(videoURL == nil || isProcessing)

            ScrollView {
                Text(outputText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .frame(width: 500, height: 400)
    }

    func processVideo(url: URL) -> String {
        guard let whisperScript = Bundle.main.path(forResource: "whisper_local", ofType: "sh") else {
            return "Erreur : script whisper_local.sh introuvable."
        }

        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = [whisperScript, url.path]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            return "Erreur lors de l'exécution du script: \(error.localizedDescription)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? "Aucune sortie du script"
    }
}
