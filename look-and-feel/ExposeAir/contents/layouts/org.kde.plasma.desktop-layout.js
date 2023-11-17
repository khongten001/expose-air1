var panel = new Panel
var panelScreen = panel.screen

panel.location = "bottom";
panel.height = 44
const geo = screenGeometry(panelScreen);
panel.alignment = "center";
panel.minimumLength = geo.width;
panel.maximumLength = geo.width;

var kickoff = panel.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["Shortcuts"]
kickoff.writeConfig("global", "Alt+F1")
kickoff.currentConfigGroup = ["General"]
kickoff.writeConfig("favorites", ["preferred://browser", "org.kde.dolphin.desktop", "org.kde.konsole.desktop", "systemsettings.desktop"])
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.pager")
let taskBar = panel.addWidget("org.kde.plasma.icontasks")
taskBar.currentConfigGroup = ["General"]
taskBar.writeConfig("launchers",["preferred://browser", "preferred://filemanager","applications:org.kde.konsole.desktop"])



var langIds = ["as",    // Assamese
               "bn",    // Bengali
               "bo",    // Tibetan
               "brx",   // Bodo
               "doi",   // Dogri
               "gu",    // Gujarati
               "hi",    // Hindi
               "ja",    // Japanese
               "kn",    // Kannada
               "ko",    // Korean
               "kok",   // Konkani
               "ks",    // Kashmiri
               "lep",   // Lepcha
               "mai",   // Maithili
               "ml",    // Malayalam
               "mni",   // Manipuri
               "mr",    // Marathi
               "ne",    // Nepali
               "or",    // Odia
               "pa",    // Punjabi
               "sa",    // Sanskrit
               "sat",   // Santali
               "sd",    // Sindhi
               "si",    // Sinhala
               "ta",    // Tamil
               "te",    // Telugu
               "th",    // Thai
               "ur",    // Urdu
               "vi",    // Vietnamese
               "zh_CN", // Simplified Chinese
               "zh_TW"] // Traditional Chinese

if (langIds.indexOf(languageId) != -1) {
    panel.addWidget("org.kde.plasma.kimpanel");
}

panel.addWidget("org.kde.plasma.systemtray")
panel.addWidget("org.kde.plasma.digitalclock")

