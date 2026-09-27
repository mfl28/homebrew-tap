cask "boundingboxeditor" do
  version "3.0.0"
  sha256 "53513218cf1666801354836ba992b1694620feefeef0fa35b3d22368632a3c22"

  url "https://github.com/mfl28/BoundingBoxEditor/releases/download/v#{version}/boundingboxeditor-#{version}.dmg"
  name "Bounding Box Editor"
  desc "Image annotation tool for bounding boxes and polygons"
  homepage "https://github.com/mfl28/BoundingBoxEditor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos
  depends_on arch: :arm64

  app "BoundingBoxEditor.app"

  # The app is not notarized, so Gatekeeper would refuse to open it while it is quarantined.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/BoundingBoxEditor.app"]
  end

  caveats <<~EOS
    Bounding Box Editor is not notarized by Apple. This cask removes the quarantine
    attribute from the installed app so that it can be opened.
  EOS
end
