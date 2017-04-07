class NoDbController < ApplicationController
  def index
    sleep(1)
    render text: "no_user"
  end
end
