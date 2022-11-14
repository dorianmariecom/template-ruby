require "spec_helper"

RSpec.describe ::Template::Parser do
  subject { ::Template::Parser.parse(input) }

  ["Hello", "Hello {name}", "Hello \\{name}"].each do |input|
    context input do
      let!(:input) { input }

      it { expect { subject }.to_not raise_error }
    end
  end
end
