class Peraz < Formula
  desc "Compress video, images, GIFs, PDFs, and e-books from the terminal"
  homepage "https://github.com/arsyadcc/peraz"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.7.0/peraz-aarch64-apple-darwin.tar.xz"
      sha256 "7778c5fad713e957ebc3f50ef043896cf5be769a71458b77913ec31106f2dd97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.7.0/peraz-x86_64-apple-darwin.tar.xz"
      sha256 "3ee7caf70733a96b5c4d740fc3946fc71cb08a3d9eb7167cee09d3f1275cb9bd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.7.0/peraz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c25f407f8e0b38a3829d07d5bb151811a7d9777916345bef1cd170463ecb2355"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.7.0/peraz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6494739a8fd38a28e1257407130be17cafbbfb49bdbd55ae3fea8a8a5aa1ace9"
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
