require 'rails_helper'

describe Move do
  it { should validate_presence_of :name }
end
