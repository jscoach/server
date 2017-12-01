require 'test_helper'
require './lib/js'

describe "License" do
  it "returns a normalized license" do
    License.normalize("MIT", fallback: nil).must_equal "MIT"
    License.normalize("mit", fallback: nil).must_equal "MIT"
    License.normalize("Apache v2", fallback: nil).must_equal "Apache-2.0"
    License.normalize("ISC", fallback: nil).must_equal "ISC"
    License.normalize("GPL-3.0", fallback: nil).must_equal "GPL-3.0"
    License.normalize("CC0-1.0", fallback: nil).must_equal "CC0-1.0"
    License.normalize("BSD-2-Clause", fallback: nil).must_equal "BSD-2-Clause"
  end
end
