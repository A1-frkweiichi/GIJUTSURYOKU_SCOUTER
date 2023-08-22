class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash={})
    hash[:uid] = User.create_unique_string
    super
  end

  def destroy
    resource.destroy
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to root_path, status: :see_other }
  end
end
