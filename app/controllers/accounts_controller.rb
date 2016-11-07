class AccountsController < ApplicationController

  def message_threads_count
    render json: {message_threads_count: @account.message_threads_count}
  end
end
