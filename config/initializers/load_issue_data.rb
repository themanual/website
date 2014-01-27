ISSUES = HashWithIndifferentAccess.new(YAML.load(IO.read(File.join(Rails.root, "config", "issues.yml"))))
