class AsmTools < Formula
  desc "AsmTools - AsmTools is a
  software package containing a collection of tools that you can use to
  encode and decode a Java class file"
  homepage "https://wiki.openjdk.java.net/display/CodeTools/asmtools"
  head "https://github.com/openjdk/asmtools.git"

  depends_on :java => "1.8+"

  depends_on "ant" => :build

  def install
    system "ant", "-Dbuild.lib.dir=#{buildpath}/target/", "-file", "build/build.xml", "jar"
    (libexec/"lib/").install "target/asmtools.jar"
    bin.write_jar_script libexec/"lib/asmtools.jar", "asmtools"
  end
end
