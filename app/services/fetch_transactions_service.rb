require 'net/http'
require 'uri'
require 'json'

class FetchTransactionsService
  API_URL = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=SECRET_API_KEY"

  def self.call
		uri = URI(API_URL)
		response = Net::HTTP.get_response(uri)
	
		return unless response.is_a?(Net::HTTPSuccess)
	
		transactions = JSON.parse(response.body) || []
	
		transactions.each do |tx|
			block_hash = tx["block_hash"]
			height     = tx["height"]
			tx_hash    = tx["hash"]
	
			tx["actions"].each do |action|
				next unless action["type"] == "Transfer"
	
				sender  = tx["sender"]
				receiver = tx["receiver"]
				deposit = action["data"]["deposit"]
	
				Transaction.find_or_create_by(hash_key: tx_hash) do |t|
					t.sender     = sender
					t.receiver   = receiver
					t.deposit    = deposit
					t.block_hash = block_hash
					t.height     = height
				end
			end
		end
	end
end