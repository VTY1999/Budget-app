require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(name: 'test') }
  before { subject.save }

  it 'should not be valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid with a duplicate name' do
    subject.name = 'test'
    expect(subject).to_not be_valid
  end
end
