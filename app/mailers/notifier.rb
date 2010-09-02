class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  
  def confirmation_instructions(record)
    setup_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record)
    setup_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    setup_mail(record, :unlock_instructions)
  end
  
  private

    # Configure default email options
    def setup_mail(record, action)
      @resource = record
      
      headers = {
        :subject => translate(action, 'subject'),
        :to => record.email
      }

      headers.merge!(record.headers_for(action)) if record.respond_to?(:headers_for)
      mail(headers)
    end
    
    # Setup subject namespaced by model. It means you're able to setup your
    # messages using specific resource scope, or provide a default one.
    # Example (i18n locale file):
    #
    # en:
    #   devise:
    # mailer:
    # confirmation_instructions: '...'
    # user:
    # confirmation_instructions: '...'
    def translate(action, key)
      I18n.t("#{action}.#{key}", :scope => [:mailer])
    end
end
