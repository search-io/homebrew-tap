class Scloud < Formula
  desc "The scloud command can be used to set up and test a Sajari collection. You can do almost everything with this command-line tool."
  homepage "https://sajari.atlassian.net/wiki/x/dYD3D"
  version "1.15.1"
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://cdn.sajari.com/v2/scloud/scloud-0.15.1.darwin-amd64.tar.gz"
    sha256 "081d0a76ed734f537a5d6840dfae950c2878ed8e44f90bd28ea7dd567f4c208b"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://cdn.sajari.com/v2/scloud/scloud-0.15.1.darwin-arm64.tar.gz"
    sha256 "78a4b60a360565a767b0e971844a22339d6184d354e2570b38de6cf413e32b9d"
  end

  def install
    bin.install "scloud"
  end

  test do
    system "#{bin}/scloud", "--version"
  end
end