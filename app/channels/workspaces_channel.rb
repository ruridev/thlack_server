class WorkspacesChannel < ApplicationCable::Channel
  def subscribed
    @channel = Channel.find_by(id: params[:channel_id])
    stream_for @channel
  end

  def unsubscribed
    # any cleanup needed when channel is unsubscribed
  end
end