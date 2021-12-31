class Scloud < Formula
  desc "The scloud command can be used to set up and test a Sajari collection. You can do almost everything with this command-line tool."
  homepage "https://sajari.atlassian.net/wiki/x/dYD3D"
  version "1.15.1"
  bottle :unneeded

  def caveats; <<~EOS
      "Run `scloud init` on initial installation, and use `scloud config get` to get the 
       current configuration, more information is available here: 
       https://sajari.atlassian.net/wiki/x/dYD3D"
    EOS
  end

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://cdn.sajari.com/v2/scloud/0.16.0/scloud-0.16.0.darwin-amd64.tar.gz"
      sha256 "b5233224a63b87e0f3facb9084a6fe8ee09bf16654ff3b02cbdfe02a59a05c34"
    end
    if Hardware::CPU.arm?
      url "https://cdn.sajari.com/v2/scloud/0.16.0/scloud-0.16.0.darwin-arm64.tar.gz"
      sha256 "b539e97322e8a1049cd3dcfdee98374b28c6a30fb9a1fcfcc5376dbeaef36e89"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://cdn.sajari.com/v2/scloud/0.16.0/scloud-0.16.0.linux-amd64.tar.gz"
    sha256 "8d068662ef1dc5eddfe2c759fefa8b5a5bfda2fe447eb410ba88c802add93f7b"
  end

  def install
    bin.install "scloud"
  end

  test do
    system "#{bin}/scloud", "--version"
  end
end