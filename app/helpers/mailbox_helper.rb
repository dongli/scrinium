module MailboxHelper
  attr_reader :unread_messages, :read_messages
  attr_reader :unread_notifications, :read_notifications

  def check_mailbox
    @unread_messages = []
    @read_messages = []
    @unread_notifications = []
    @read_notifications = []
    current_user.mailbox.inbox.each do |c|
      c.messages.each do |m|
        if m.is_unread? current_user
          @unread_messages << m
        else
          @read_messages << m
        end
      end
    end
    current_user.mailbox.notifications.each do |n|
      if n.is_unread? current_user
        @unread_notifications << n
      else
        @read_notifications << n
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
