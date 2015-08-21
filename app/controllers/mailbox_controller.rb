class MailboxController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox = current_user.mailbox.inbox
    @active = :inbox
  end

  def sentbox
    @sentbox = current_user.mailbox.sentbox
    @active = :sentbox
  end

  def trash
    @trash = current_user.mailbox.trash
    @active = :trash
  end
end
