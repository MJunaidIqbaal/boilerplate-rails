module AuthenticableApiUser
  extend ActiveSupport::Concern

  private

    def ready?(*)
      return true if context[:current_user]

      raise unauthorized_error
    end

    def unauthorized_error
      GraphQL::ExecutionError.new("Unauthorized error", options: { status: :unauthorized, code: 401 })
    end
end