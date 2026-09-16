class Skillspub < Formula
  desc "Multi-agent skills on/off manager (disk is the source of truth)"
  homepage "https://github.com/AlligatorT/SkillsPub"
  url "https://registry.npmjs.org/skillspub/-/skillspub-0.1.0.tgz"
  sha256 "cd6b603cf92a36ee61c6b3796fed229e9d1daa4ef8d4406280559ea72b7efdc7"
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
