cask 'microsoft-edge' do
  version '81.0.416.64'
  sha256 '2fc32b63c7a9ad530d8efa3dcd539a1829187124bcc215ad75d2ee4d69261680'

  # officecdn-microsoft-com.akamaized.net/ was verified as official when first introduced to the cask
  url "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/MicrosoftEdge-#{version}.pkg"
  appcast 'https://macupdater.net/cgi-bin/check_urls/check_url_redirect.cgi?url=https://go.microsoft.com/fwlink/?linkid=2069148'
  name 'Microsoft Edge'
  homepage 'https://www.microsoft.com/edge'

  auto_updates true

  pkg "MicrosoftEdge-#{version}.pkg"

  uninstall pkgutil: 'com.microsoft.edgemac',
            rmdir:   '/Library/Application Support/Microsoft'

  zap launchctl: [
                   'com.microsoft.autoupdate.helper',
                   'com.microsoft.update.agent',
                 ],
      pkgutil:   'com.microsoft.package.Microsoft_AutoUpdate.app',
      delete:    '/Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper',
      trash:     [
                   '/Library/Application Support/Microsoft',
                   '~/Library/Application Support/Microsoft Edge',
                   '~/Library/Caches/Microsoft Edge',
                   '~/Library/Preferences/com.microsoft.edgemac.plist',
                   '~/Library/Saved Application State/com.microsoft.edgemac.savedState',
                 ]
end
