# frozen_string_literal: true
require 'rails_helper'
require 'json'

describe 'Types::UserType', type: :request do
  let!(:account) { create :account }
  let!(:user) { create :user }
  let!(:account_user) { create :account_user, account: account, user: user }

  describe '.users' do
    let(:query) do
      <<~GQL
        query {
          users {
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
            'users' => [
              {
                'id' => user.id.to_s,
              }
            ],
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_account).and_return(account)
      end

      it 'account 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.user' do
    let(:query) do
      <<~GQL
        query {
          user(id: #{user.id}) {
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
            'user' => {
              'id' => user.id.to_s,
            },
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'user 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.token' do
    let(:query) do
      <<~GQL
        query {
          token(userId: #{user.id})
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
            'token' => 'token'
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_account).and_return(account)
      end

      it 'token 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.login_user' do
    let(:query) do
      <<~GQL
        query {
          loginUser {
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
            'loginUser' => {
              'id' => user.id.to_s
            }
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'login_user 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end
end
