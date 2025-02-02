require 'rails_helper'

RSpec.describe AuthenticableApiUser do
  let(:user) { create(:user) }
  let(:query) { 'mutation { orderGenerator( number: 1 ) { number } }' }
  let(:result) { GraphqlBoilerplateSchema.execute(query) }
  let(:result_1) { GraphqlBoilerplateSchema.execute(query, context: { current_user: user }) }

  context "Methods" do
    it "should check #ready?" do
      expect(result["errors"][0]["message"]).to eql("Unauthorized error")
    end

    it "should check #ready? when #current_user is present" do
      expect(result_1.dig('data', 'orderGenerator', 'number')).to eq(1)
    end

    it "should check #execution_error" do
      class Order; include AuthenticableApiUser; end
      expect(Order.new.send(:unauthorized_error)).to be_instance_of(GraphQL::ExecutionError)
    end
  end
end