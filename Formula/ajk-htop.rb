class AjkHtop < Formula
  desc "Improved top (interactive process viewer)"
  homepage "https://github.com/RobberPhex/htop"
  head "https://github.com/RobberPhex/htop.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "pkg-config" => :build
  depends_on "ncurses" # enables mouse scroll

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    htop requires root privileges to correctly display all running processes,
    so you will need to run `sudo htop`.
    You should be certain that you trust any software you grant root privileges.
  EOS
  end

  test do
    pipe_output("#{bin}/htop", "q", 0)
  end
end
