VERIFIER = ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
