class GitlabGem < Formula
  desc "Ruby client and CLI for GitLab API"
  homepage "https://github.com/NARKOZ/gitlab"
  url "https://github.com/NARKOZ/gitlab/archive/v4.3.0.tar.gz"
  sha256 "b2679d0696642f67ba84a4f9df21ad4a7bf1bc814d7f86218b72ebe5e56ff2d0"
  head "https://github.com/NARKOZ/gitlab.git"

  resource "httparty" do
    url "https://rubygems.org/gems/httparty-0.16.0.gem"
    sha256 "c3e08fac9079fdbe175158782c61f6db6a1918446399560d0bfce1e752b5a5d2"
  end

  resource "terminal-table" do
    url "https://rubygems.org/gems/terminal-table-1.8.0.gem"
    sha256 "13371f069af18e9baa4e44d404a4ada9301899ce0530c237ac1a96c19f652294"
  end

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "gitlab.gemspec"
    system "gem", "install", "gitlab-#{version}.gem"
    bin.install "exe/gitlab"
    bin.env_script_all_files(libexec/"exe", :GEM_HOME => ENV["GEM_HOME"])
    libexec.install Dir["*"]
  end

  test do
    assert_equal "Please set an endpoint to API", shell_output("#{bin}/gitlab user").strip
  end
end
