# frozen_string_literal: true
require 'rails_helper'
require 'json'

describe 'Types::WorkspaceType', type: :request do
  let!(:account) { create :account }
  let!(:user) { create :user }
  let!(:account_user) { create :account_user, account: account, user: user }
  let!(:workspace) { create :workspace }
  let!(:workspace_user) { create :workspace_user, workspace: workspace, user: user }
  describe '.workspaces' do
    let(:query) do
      <<~GQL
        query {
          workspaces {
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
            'workspaces' => [
              {
                'id' => workspace.id.to_s,
              }
            ],
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'workspace 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end

  describe '.workspace' do
    let(:query) do
      <<~GQL
        query {
          workspace(id: #{workspace.id}) {
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
            'workspace' => {
              'id' => workspace.id.to_s,
            },
          },
        }
      end

      before do
        allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      end

      it 'workspace 정보 반환' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end
end
