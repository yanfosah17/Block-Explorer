require "test_helper"
require "webmock/minitest"

class FetchTransactionsServiceTest < ActiveSupport::TestCase
  setup do
    WebMock.disable_net_connect!(allow_localhost: true)
    Transaction.delete_all
  end

  test "should fetch and store transfer transactions" do
    # Mock API response
    mock_response = [
      {
        "block_hash" => "mock_block_hash",
        "height" => 123,
        "hash" => "mock_tx_hash",
        "sender" => "sender.near",
        "receiver" => "receiver.near",
        "actions" => [
          { "type" => "Transfer", "data" => { "deposit" => 1000 } }
        ]
      }
    ].to_json

    stub_request(:get, /mock.pstmn.io/)
      .to_return(status: 200, body: mock_response)

    assert_difference("Transaction.count", 1) do
      FetchTransactionsService.call
    end

    # Verify data was saved correctly
    transaction = Transaction.last
    assert_equal "mock_tx_hash", transaction.hash_key
    assert_equal "sender.near", transaction.sender
    assert_equal "receiver.near", transaction.receiver
    assert_equal 1000, transaction.deposit
    assert_equal "mock_block_hash", transaction.block_hash
    assert_equal 123, transaction.height
  end

  test "should ignore non-transfer transactions" do
    # Mock API response with non-transfer action
    mock_response = [
      {
        "block_hash" => "mock_block_hash",
        "height" => 123,
        "hash" => "mock_tx_hash",
        "sender" => "sender.near",
        "receiver" => "receiver.near",
        "actions" => [
          { "type" => "FunctionCall", "data" => { "method_name" => "ping" } }
        ]
      }
    ].to_json

    stub_request(:get, /mock.pstmn.io/)
      .to_return(status: 200, body: mock_response)

    assert_no_difference("Transaction.count") do
      FetchTransactionsService.call
    end
  end

  test "should handle empty API response" do
    stub_request(:get, /mock.pstmn.io/)
      .to_return(status: 200, body: [].to_json)

    assert_no_difference("Transaction.count") do
      FetchTransactionsService.call
    end
  end

  test "should handle failed API requests" do
    stub_request(:get, /mock.pstmn.io/)
      .to_return(status: 500, body: "Internal Server Error")

    assert_no_difference("Transaction.count") do
      FetchTransactionsService.call
    end
  end
end
