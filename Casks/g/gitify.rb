cask "gitify" do
  version "5.6.0"
  sha256 "1d4db3eee156b3d0b9508386bda79b97feab37f50727cfcdcc71ebc40dd56163"

  url "https://github.com/gitify-app/gitify/releases/download/v#{version}/Gitify-#{version}-universal-mac.zip"
  name "Gitify"
  desc "GitHub Notifications on your menu bar"
  homepage "https://github.com/gitify-app/gitify"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Gitify.app"

  preflight do
    retries ||= 3
    ohai "Attempting to close Gitify.app to avoid unwanted user intervention" if retries >= 3
    return unless system_command "/usr/bin/pkill", args: ["-f", "/Applications/Gitify.app"]
  rescue RuntimeError
    sleep 1
    retry unless (retries -= 1).zero?
    opoo "Unable to forcibly close Gitify.app"
  end

  uninstall quit: [
    "com.electron.gitify",
    "com.electron.gitify.helper",
  ]

  zap trash: [
    "~/Library/Application Support/gitify",
    "~/Library/Preferences/com.electron.gitify.helper.plist",
    "~/Library/Preferences/com.electron.gitify.plist",
    "~/Library/Saved Application State/com.electron.gitify.savedState",
  ]
end
