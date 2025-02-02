module Types
  module Users
    class ObjectType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
      field :phone_no, String, null: true
      field :type, String, null: false
      field :profile_picture, Types::Shared::ImageType, null: true
      field :revoke_access, Boolean, null: false
      field :deleted, Boolean, null: false
      field :terms_and_conditions, Boolean, null: false
      field :invitation_status, String, null: true

      field :invitation_accepted, Boolean, null: false
      field :raw_invitation_token, String, null: false
      field :invited_by, ObjectType, null: true
      field :invitees, [ObjectType], null: true

      def invitation_accepted
        object.invitation_accepted?
      end

      def raw_invitation_token
        object.raw_invitation_token
      end

      def type
        Resolvers::UserResolvers.new(object).type
      end

      def profile_picture
        if object.profile_picture.attached?
          {
            id: object.profile_picture.blob_id,
            url: Rails.application.routes.url_helpers.rails_blob_url(object.profile_picture, only_path: true)
          }
        end
      end
    end
  end
end