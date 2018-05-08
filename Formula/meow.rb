require "language/go"

class Meow < Formula
  homepage "https://github.com/netheril96/MEOW"
  version "1.5"
  url "https://github.com/netheril96/MEOW/archive/#{version}.tar.gz"
  sha256 "5c5244f0ab539550c0e350b348245d2add599237af217152604ee126c6a866a3"

  depends_on "go" => :build

  def install
      ENV["GOPATH"] = buildpath
      mkdir_p "src/github.com/netheril96"
      ln_s buildpath, "src/github.com/netheril96/MEOW"
      system "go", "get", "github.com/netheril96/MEOW"
      system "go", "build", "-o", "MEOW", "github.com/netheril96/MEOW"
      bin.install "MEOW"

      (buildpath/"etc/meow/rc").write <<~EOS
        listen = http://0.0.0.0:8008
        proxy = socks5://127.0.0.1:1080
      EOS
      cp "doc/sample-config/direct", "etc/meow/"
      cp "doc/sample-config/proxy", "etc/meow/"
      cp "doc/sample-config/reject", "etc/meow/"
      etc.install "etc/meow"
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/meow/bin/MEOW -rc #{HOMEBREW_PREFIX}/etc/meow/rc"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/MEOW</string>
          <string>-rc</string>
          <string>#{etc}/meow/rc</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>NetworkState</key>
          <true/>
        </dict>
        <key>SoftResourceLimits</key>
        <dict>
          <key>NumberOfFiles</key>
          <integer>20480</integer>
        </dict>
      </dict>
    </plist>
    EOS
  end
end
