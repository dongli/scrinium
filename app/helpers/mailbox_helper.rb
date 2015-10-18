module MailboxHelper
  attr_reader :unread_messages, :read_messages, :sent_messages, :trashed_messages
  attr_reader :unread_notifications, :read_notifications, :trashed_notifications

  def check_mailbox
    @unread_messages = []
    @read_messages = []
    @unread_notifications = []
    @read_notifications = []
    @sent_messages = []
    @trashed_messages = []
    @trashed_notifications = []
    current_user.mailbox.inbox.each do |conversation|
      conversation.messages.each do |message|
        next if message.sender == current_user
        if message.is_unread? current_user
          @unread_messages << message
        else
          @read_messages << message
        end
      end
    end
    current_user.mailbox.notifications.each do |notification|
      next if notification.is_deleted? current_user
      if notification.is_trashed? current_user
        @trashed_notifications << notification
      elsif notification.is_unread? current_user
        @unread_notifications << notification
      else
        @read_notifications << notification
      end
    end
    current_user.mailbox.sentbox.each do |conversation|
      conversation.messages.each do |message|
        next if message.sender != current_user
        @sent_messages << message
      end
    end
    current_user.mailbox.trash.each do |conversation|
      conversation.messages.each do |message|
        next if not message.is_trashed? current_user
        @trashed_messages << message
      end
    end
  end

  def num_unread
    @unread_messages.size + @unread_notifications.size
  end

  def has_unread?
    num_unread > 0
  end
end
