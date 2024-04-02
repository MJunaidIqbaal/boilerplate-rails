module Types
  module Users
    class AccessAttributes < Types::BaseInputObject
      argument :revoke_access, Boolean, required: true
      argument :deleted, Boolean, required: false
      argument :role, Types::Users::UserTypeEnum, required: false
    end
  end
end