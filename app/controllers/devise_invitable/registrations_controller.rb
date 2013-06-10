class DeviseInvitable::RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash = nil)
    hash ||= resource_params || {}
    if hash[:email]
      self.resource = resource_class.to_adapter.find_first(:email => hash[:email], :encrypted_password => '')
      if self.resource
        self.resource.attributes = hash
        self.resource.accept_invitation
      end
    end
    self.resource ||= super
  end
end
