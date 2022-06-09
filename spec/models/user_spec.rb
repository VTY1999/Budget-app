require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'user@gmail.com', name: 'John doe', password: 'password') }
  before { subject.save }

  it 'should not be valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
