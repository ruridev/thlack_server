class ChannelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end