class Peraz < Formula
  desc "Compress video, images, GIFs, PDFs, and e-books from the terminal"
  homepage "https://github.com/arsyadcc/peraz"
  version "0.1.0-alpha.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.3/peraz-aarch64-apple-darwin.tar.xz"
      sha256 "afc8e29bc6a4819b4794a223997590f9d1078c1346e64962b6c2aeea8a931acd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.3/peraz-x86_64-apple-darwin.tar.xz"
      sha256 "bc1a42155318eeecf1544945a9ef64a72d14988d426ad76bc822c8649ef06d4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.3/peraz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9dc7618ac1d96ae5512bad30a57166790306e4fd5504ae01b021e89c874aab54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.3/peraz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3484d27b390fe0e9b581b24c937ceaf485ad61259e986a59268e2127d597f7e"
    end
  end
  license "GPL-3.0-or-later"
  depends_on "ffmpeg"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "peraz"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "peraz"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "peraz"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "peraz"
    end

    install_binary_aliases!

    generate_completions_from_executable(bin/"peraz", "completions")

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
