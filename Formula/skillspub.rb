class Skillspub < Formula
  desc "Multi-agent skills on/off manager (disk is the source of truth)"
  homepage "https://github.com/AlligatorT/SkillsPub"
  url "https://registry.npmjs.org/skillspub/-/skillspub-0.2.0.tgz"
  sha256 "bee2e478c8278996651a11c2f7c862d143e9f28ce9873a9fa4ca2a6f37e1987d"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/skillspub targets --json")
    json = JSON.parse(output)
    assert_equal 1, json["schemaVersion"]
    shared = json["data"].find { |t| t["key"] == "shared" }
    refute_nil shared, "expected a shared Skill Target"
    assert_includes shared["discoveryRoot"], ".agents/skills"
  end
end
