class ChatsController < ApplicationController
    
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    each_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless each_room.nil?
      @room = each_room.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    unless @chat.save
      render 'error'
    end
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
  end

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
end
