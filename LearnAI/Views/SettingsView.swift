import SwiftUI

struct SettingsView: View {

    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @AppStorage("autoLearn") private var autoLearn = false

    var body: some View {

        NavigationStack {

            List {

                Section("Learning") {

                    Toggle("Auto Learn", isOn: $autoLearn)

                }

                Section("Experience") {

                    Toggle("Sound Effects", isOn: $soundEnabled)

                    Toggle("Haptics", isOn: $hapticsEnabled)

                    Toggle("Dark Mode", isOn: $darkMode)

                }

                Section("About") {

                    LabeledContent("Version", value: "1.0")

                    LabeledContent("AI Model", value: "Gemini")

                }

            }
            .navigationTitle("Settings")

        }

    }

}

#Preview {
    SettingsView()
}
