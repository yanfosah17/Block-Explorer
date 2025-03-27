class TransactionsController < ApplicationController
  def index
    FetchTransactionsService.call
    @transactions = Transaction.order(height: :desc)
  end
end