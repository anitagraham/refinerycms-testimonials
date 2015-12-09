module Selectors
  Capybara.add_selector(:linkhref) do
    xpath {|href| ".//a[@href='#{href}']"}
  end
end

def ensure_on(path)
  visit(path) unless current_path == path
end

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behaviour, 'has behaviour:'
  # c.alias_it_should_not_behave_like_to :it_does_not_have_behaviour,
end

RSpec::Matchers.define :each do |meta|
  match do |actual|
    actual.each_with_index do |i, j|
      @elem = j
      i.should meta
    end
  end

  failure_message_for_should do |actual|
    "at[#{@elem}] #{meta.failure_message}"
  end
end


RSpec::Matchers.define :be_ordered_by do |attribute|
  match do |actual|
    result = true
    reverse_indicator = "_desc"
    if attribute =~ /#{reverse_indicator}/
      symbol = attribute.gsub(/#{reverse_indicator}/,'').to_sym
      sorted = actual.sort{ |a,b| b.send(symbol) <=> a.send(symbol)}
    else
      sorted = actual.sort{ |a,b| a.updated_at <=> b.updated_at}
    end
    sorted.each_with_index do |a,i|
      result = false unless actual[i] == a
    end
  result # return true or false for this matcher.
  end

  failure_message do |actual|
    "expected that #{actual} would be sorted by #{attribute}"
  end

  failure_message do |actual|
    "expected that #{actual} would not be sorted by #{attribute}"
  end

  description do
    "be a sorted by #{attribute}"
  end
end