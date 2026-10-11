cask "boundingboxeditor" do
  # The Apple Silicon disk image has no suffix, the Intel one "-intel".
  arch intel: "-intel"

  version "3.2.0"
  sha256 arm:   "f809f1a0d1a3b6faf59bbf71f0c5fe3cb3940d68f6d9881f5691622bbcb2d227",
         intel: "c64c4eac4aa291bfb55207c9b19e57e25f1abe2d916da148f43571740283cfac"

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
