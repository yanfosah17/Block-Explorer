class TransactionsController < ApplicationController
  def index
    begin
      FetchTransactionsService.call
      @api_available = true
    rescue StandardError
      @api_available = false
    end

    @transactions = Transaction.order(height: :desc)
  end
end