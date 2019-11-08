module ApiGuardian
  module Validators
    class PasswordScoreValidator < ActiveModel::Validator
      def validate(record)
        return unless ApiGuardian.configuration.validate_password

        if (record.password =~ ApiGuardian.configuration.password_regex).nil?
          record.errors[:password] << 'is not strong enough. Consider ' \
            'adding a number, symbols or more letters to make it stronger.'
        end
      end
    end
  end
end
