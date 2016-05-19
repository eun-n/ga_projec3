class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @users = User.all
  end

  def create
    @message = Message.create message_params
    PrivatePub.publish_to "/messages/new", :message => @message
    redirect_to :back
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
