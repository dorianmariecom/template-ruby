class Template
  class Parser
    class Nothing < Parslet::Parser
      rule(:nothing_keyword) { str("nothing") }
      rule(:null_keyword) { str("null") }
      rule(:nil_keyword) { str("nil") }

      rule(:nothing) do
        (nothing_keyword | null_keyword | nil_keyword).as(:nothing)
      end

      root(:nothing)
    end
  end
end
