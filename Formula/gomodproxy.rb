class Gomodproxy < Formula
  desc "Go module proxy for downloading Sajari code"
  homepage "https://review.sajari.com/admin/repos/gomodproxy"
  url "ssh://review.sajari.com:29418/gomodproxy",
    using:    :git,
    revision: "07f82d6edf20a7e71717b2d9fc3add8a54a700c8"
  version "1.0.0"
  head "ssh://review.sajari.com:29418/gomodproxy",
    using:  :git,
    branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "gomodproxy-local", "./cmd/gomodproxy-local"
    bin.install "gomodproxy-local"
    etc.install "cmd/gomodproxy-cloudbuild/config.yaml" => "gomodproxy.yaml"
  end

  def caveats
    <<~EOS
      Setup your development environment with:
        export GONOSUMDB="code.sajari.com,go.sajari.com"
        export GOPROXY="http://localhost:9191,https://proxy.golang.org,direct"
    EOS
  end

  plist_options startup: true, manual: "gomodproxy-local -config=#{HOMEBREW_PREFIX}/etc/gomodproxy.yaml -listen=localhost:9191"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/gomodproxy-local</string>
            <string>-config=#{etc}/gomodproxy.yaml</string>
            <string>-listen=localhost:9191</string>
          </array>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>StandardErrorPath</key>
          <string>/dev/null</string>
          <key>StandardOutPath</key>
          <string>/dev/null</string>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_match "version #{version}", shell_output("#{bin}/gomodproxy-local -version")
  end
end
