dir = File.expand_path(File.dirname(__FILE__))
[ "#{dir}/../../lib", "#{dir}/../../test/lib"].each do |dir|
    fulldir = File.expand_path(dir)
    $LOAD_PATH.unshift(fulldir) unless $LOAD_PATH.include?(fulldir)
end

require 'spec'
require 'puppettest'
require 'puppettest/runnable_test'

module Spec
  module Runner
    class ExampleGroupRunner
      def run_behaviours
        @behaviours.each do |behaviour|
          # LAK:NOTE: this 'runnable' test is Puppet-specific.
          next unless behaviour.runnable?
          behaviour.run(@options.reporter, @options.dry_run, @options.reverse, @options.timeout)
        end
      end
    end
  end
end

module Spec
  module Example
    class ExampleGroup
      extend PuppetTest::RunnableTest
    end
  end
end

module Test
  module Unit
    class TestCase
      extend PuppetTest::RunnableTest
    end
  end
end
