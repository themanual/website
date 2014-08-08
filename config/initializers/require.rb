Dir[File.join(Rails.root, "lib", "core_extensions", "*.rb")].each {|l| require l }
Dir[File.join(Rails.root, "lib", "the_manual", "*.rb")].each {|l| require l }