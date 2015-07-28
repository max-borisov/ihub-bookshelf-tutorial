require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe 'user_gravatar' do
    let(:gravatar) { user_gravatar('user@gmail.com', 200) }

    it 'has gravatar domain name' do
      expect(gravatar).to include('www.gravatar.com')
    end

    it 'has gravatar size specified' do
      expect(gravatar).to include('?s=200')
    end
  end
end
