class Peraz < Formula
  desc "Compress video, images, GIFs, PDFs, and e-books from the terminal"
  homepage "https://github.com/arsyadcc/peraz"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.3.0/peraz-aarch64-apple-darwin.tar.xz"
      sha256 "9593ad5c620ded73c539a5096ebb6f06d450aa747d6505650c011a19e64fc5e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.3.0/peraz-x86_64-apple-darwin.tar.xz"
      sha256 "6f60543152d274abcec6f7ee2becbe6472f86d9f5e6202e69df8130aafc856fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.3.0/peraz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c079e6ba83ba60f8791c9666b5f76db97b82d4a234de6791e4143acd4b02d022"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.3.0/peraz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "42bd73f53d92918ffa9c03355b99211cc06664bdfb4d2e967bb713c7895d6f35"
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

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
