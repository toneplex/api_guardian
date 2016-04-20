describe ApiGuardian::Strategies::Registration do
  describe 'methods' do
    describe '.find_strategy' do
      it 'finds a registered strategy' do
        mock_array = double([])
        expect(ApiGuardian::Strategies::Registration::Base).to receive(:providers).and_return(mock_array)
        expect(mock_array).to receive(:[]).and_return(:test)
        expect { ApiGuardian::Strategies::Registration.find_strategy(:test) }.not_to raise_error
      end

      it 'fails if strategy is not found' do
        mock_array = double([])
        expect(ApiGuardian::Strategies::Registration::Base).to receive(:providers).twice.and_return(mock_array)
        expect(mock_array).to receive(:[]).and_return(nil)
        expect(mock_array).to receive(:keys).and_return([])
        expect { ApiGuardian::Strategies::Registration.find_strategy(:test) }.to(
          raise_error ApiGuardian::Errors::InvalidRegistrationProvider
        )
      end
    end
  end
end
