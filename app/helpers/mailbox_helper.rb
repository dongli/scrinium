module MailboxHelper
  attr_reader :unread_messages, :read_messages, :sent_messages, :trashed_messages
  attr_reader :unread_notifications, :read_notifications

  def check_mailbox
    @unread_messages = []
    @read_messages = []
    @unread_notifications = []
    @read_notifications = []
    @sent_messages = []
    @trashed_messages = []
    current_user.mailbox.inbox.each do |c|
      c.messages.each do |m|
        next if m.sender == current_user
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
    current_user.mailbox.sentbox.each do |c|
      c.messages.each do |m|
        next if m.sender != current_user
        @sent_messages << m
      end
    end
    current_user.mailbox.trash.each do |c|
      c.messages.each do |m|
        next if not m.is_trashed? current_user
        @trashed_messages << m
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
