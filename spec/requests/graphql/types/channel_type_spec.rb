# frozen_string_literal: true
require 'rails_helper'
require 'json'

describe 'Types::ChannelType', type: :request do
  let!(:account) { create :account }
  let!(:user) { create :user }
  let!(:account_user) { create :account_user, account: account, user: user }
  let!(:channel) { create :channel }
  let!(:channel_user) { create :channel_user, channel: channel, user: user }
  describe '.channels' do
    let(:query) do
      <<~GQL
        query {
          channels {
            id
          }
        }
      GQL
    end

    subject do
      post '/graphql', params: { query: query }
    end

    context '미로그인 상태' do 
      it do
        expect{ subject }.to raise_error('Unauthorized')
      end
    end

    context '계정 로그인 상태' do
      let(:expected_response) do
        {
          'data' => {
            'channels' => [
              {
                'id' => channel.id.to_s,
              }
            ],
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'channel 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.channel' do
    let(:query) do
      <<~GQL
        query {
          channel(id: #{channel.id}) {
            id
          }
        }
      GQL
    end

    subject do
      post '/graphql', params: { query: query }
    end

    context '미로그인 상태' do 
      it do
        expect{ subject }.to raise_error('Unauthorized')
      end
    end

    context '유저 로그인 상태' do
      let(:expected_response) do
        {
          'data' => {
            'channel' => {
              'id' => channel.id.to_s,
            },
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'channel 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.join_channel' do
    let(:query) do
      <<~GQL
        query {
          joinChannel(id: #{channel.id}) {
            id
          }
        }
      GQL
    end

    subject do
      post '/graphql', params: { query: query }
    end

    context '미로그인 상태' do 
      it do
        expect{ subject }.to raise_error('Unauthorized')
      end
    end

    context '유저 로그인 상태' do
      let(:expected_response) do
        {
          'data' => {
            'joinChannel' => {
              'id' => channel.id.to_s,
            },
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'channel 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end
end
