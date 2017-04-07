class DbController < ApplicationController
  def index
    @user = User.find_or_create_by!(name: "Valentin Mihov", email: "valentin.mihov@gmail.com")
    sleep(1)
    render text: @user.id
  end
end
