require "test_helper"
require "webmock/minitest"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  test "should get index" do
    # Stub the API response using WebMock
    stub_request(:get, "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=SECRET_API_KEY")
      .to_return(status: 200, body: [].to_json, headers: {})
    
    get root_url
    assert_response :success
  end
end