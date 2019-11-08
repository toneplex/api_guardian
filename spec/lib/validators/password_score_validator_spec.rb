describe ApiGuardian::Validators::PasswordScoreValidator do
  # Methods
  context 'methods' do
    describe '#validate' do
      it 'can be toggled on and off' do
        # Off
        allow_any_instance_of(ApiGuardian::Configuration).to(
          receive(:validate_password).and_return(false)
        )

        record = create(:user)

        expect(record.errors).not_to include(:password)

        record.password = 'password'

        subject.validate(record)

        expect(record.errors).not_to include(:password)

        # On
        allow_any_instance_of(ApiGuardian::Configuration).to(
          receive(:validate_password).and_return(true)
        )

        record = create(:user)

        expect(record.errors).not_to include(:password)

        record.password = 'pass'

        subject.validate(record)

        expect(record.errors).to include(:password)
      end

      it 'checks that a password passes configured regex' do
        allow_any_instance_of(ApiGuardian::Configuration).to(
          receive(:validate_password).and_return(true)
        )
        allow_any_instance_of(ApiGuardian::Configuration).to(
          receive(:password_regex).and_return(regex = /\A(?=.{8,})/x)
        )

        record = create(:user)

        expect(record.errors).not_to include(:password)

        record.password = '1234'

        subject.validate(record)

        expect(record.errors).to include(:password)

        record = create(:user)
        record.password = Faker::Internet.password(32)
        subject.validate(record)

        expect(record.errors).not_to include(:password)
      end
    end
  end
end
