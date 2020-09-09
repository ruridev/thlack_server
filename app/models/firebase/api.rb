module Firebase
  class Api
    PRIVATE_KEY_PATH = '/config/firebase-adminsdk.json'

    def self.verify(id_token)
      FirebaseIdToken::Certificates.request!
      FirebaseIdToken::Signature.verify(id_token)
    end    
  end
end
