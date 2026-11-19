class Peraz < Formula
  desc "Compress video, images, GIFs, PDFs, and e-books from the terminal"
  homepage "https://github.com/arsyadcc/peraz"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.8.0/peraz-aarch64-apple-darwin.tar.xz"
      sha256 "ef96687537efceeaf5d03ffdaa1c18a98cf883df7b69f9c3a5d6a5f805be1012"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.8.0/peraz-x86_64-apple-darwin.tar.xz"
      sha256 "96f85539e3cb0b2dae899c9045b0607bfb63c5c5c753463fd085a3f1e724380e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.8.0/peraz-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56aa116e5a3a0da4839cffddf8f4086c26cdb20636727feaf9512708c3ca6927"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arsyadcc/peraz/releases/download/v0.8.0/peraz-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e5d14aad227912d97b68b751e76b4571d8d8a0a8b15ad8397adaa3901a5b63d2"
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
