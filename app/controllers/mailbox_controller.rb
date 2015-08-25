class MailboxController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def reply_message
    @message = Mailboxer::Message.find params[:id]
    respond_to do |format|
      format.js
    end
  end

  def write_message
    @message = Mailboxer::Message.new
    respond_to do |format|
      format.js
    end
  end

  def send_message
    if params.has_key? :message_id
      # Reply message.
      parent_message = Mailboxer::Message.find params[:message_id]
      conversation = Mailboxer::Conversation.find parent_message.conversation_id
      current_user.reply_to_conversation(conversation, params[:body], params[:subject])
      @message = conversation.messages.last
    else
      # Write message.
      current_user.send_message(User.find(params[:receivers]), params[:body], params[:subject])
      @message = current_user.mailbox.sentbox.last.messages.first
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_message
    @message = Mailboxer::Message.find params[:id]
    if @message.is_trashed? current_user
      @message.mark_as_deleted current_user
      @action = :delete
    else
      @message.move_to_trash current_user
      @action = :trash
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_notification
    @notification = current_user.mailbox.notifications.find(params[:id])
    if @notification.is_trashed? current_user
      @notification.mark_as_deleted current_user
      @action = :delete
    else
      @notification.move_to_trash current_user
      @action = :trash
    end
    respond_to do |format|
      format.js
    end
  end

  def empty_trash
    current_user.mailbox.trash.each do |c|
      c.messages.each do |m|
        next if not m.is_trashed? current_user
        m.mark_as_deleted current_user
      end
    end
    current_user.mailbox.notifications.each do |n|
      next if not n.is_trashed? current_user
      n.mark_as_deleted current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def restore_message
    @message = Mailboxer::Message.find params[:id]
    @message.untrash current_user
    @box = @message.sender == current_user ? 'sentbox' : 'inbox'
    respond_to do |format|
      format.js
    end
  end
end
