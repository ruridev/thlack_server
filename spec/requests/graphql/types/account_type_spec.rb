# frozen_string_literal: true
require 'rails_helper'
require 'json'

describe 'Types::AccountType', type: :request do
  describe '.account' do
    let(:user) { create(:user) }
    let(:account) { create(:account, user: user) }
    let(:query) do
      <<~GQL
        query {
          account(id: #{account.id}) {
            identifier
          }
        }
      GQL
    end

    subject do
      post '/graphql', params: { query: query }
    end

    context 'account 가 존재하지 않는 경우' do 
      before do
        account.destroy
      end

      it do
        subject
        json = JSON.parse(response.body)
        expect(json['data']).to eq nil
      end
    end

    context 'account 가 존재하는 경우' do
      let(:user) { create(:user) }
      let(:account) { create(:account, user: user) }
      let(:expected_response) do
        {
          'data' => {
            'account' => {
              'identifier' => account.identifier,
            },
          },
        }
      end

      it 'account 정보를 반환한다' do
        subject
        json = JSON.parse(response.body)
        expect(json).to eq expected_response
      end
    end
  end
end
