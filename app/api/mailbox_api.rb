class MailboxAPI < Grape::API
  resource :mailbox do
    desc 'Mark a message as read.'
    params do
      requires :user_id, type: Integer, desc: 'User ID.'
      requires :message_id, type: Integer, desc: 'Message ID.'
    end
    post :mark_message_as_read do
      user = User.find(params[:user_id])
      message = Mailboxer::Message.find(params[:message_id])
      message.mark_as_read user
    end

    desc 'Mark a notification as read.'
    params do
      requires :user_id, type: Integer, desc: 'User ID.'
      requires :notification_id, type: Integer, desc: 'Notification ID.'
    end
    post :mark_notification_as_read do
      user = User.find(params[:user_id])
      notification = user.mailbox.notifications.find(params[:notification_id])
      notification.mark_as_read user
    end
  end
end
