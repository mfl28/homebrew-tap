cask "boundingboxeditor" do
  # The Apple Silicon disk image has no suffix, the Intel one "-intel".
  arch intel: "-intel"

  version "3.1.0"
  sha256 arm:   "16cddaf4dff1c3f653a1e2bb784cc1ea44e464c198b47ef8353d223d18379cf5",
         intel: "851dab6281a40f765b3f7aee18ec75e71414be721d5f3d98223adfa9dd7eded2"

  url "https://github.com/mfl28/BoundingBoxEditor/releases/download/v#{version}/boundingboxeditor-#{version}#{arch}.dmg"
  name "Bounding Box Editor"
  desc "Image annotation tool for bounding boxes, polygons and masks"
  homepage "https://github.com/mfl28/BoundingBoxEditor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

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
