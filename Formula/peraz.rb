class Peraz < Formula
  desc "Compress video, images, GIFs, PDFs, and e-books from the terminal"
  homepage "https://github.com/arsyadcc/peraz"
  version "0.1.0-alpha.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.2/peraz-aarch64-apple-darwin.tar.xz"
      sha256 "819d49e5e4d02bbe43dcd82953fd2ae48b3bccfe8892782f93b06dda9a594453"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.2/peraz-x86_64-apple-darwin.tar.xz"
      sha256 "96aa71cb15755dd27ccd1b87b2371561cb3d57a4c6409d9c50b32661807dd00f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.2/peraz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a1f3cc24f555059954651a75536dc5fc536d336130d39df8808ae412c04d70ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.1.0-alpha.2/peraz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f1595d48c4aecdb1b99f2ebcd4387da13981b6796ea7d1e515ade78be5e3271f"
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
