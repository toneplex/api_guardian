module ApiGuardian
  module Validators
    class PasswordScoreValidator < ActiveModel::Validator
      def validate(record)
        return unless ApiGuardian.configuration.validate_password

        if (record.password =~ ApiGuardian.configuration.password_regex).nil?
          record.errors.add(:password, :invalid)
        end
      end
    end
  end
end
