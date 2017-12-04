class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    resource = build_resource({})
    resource.user_instruments.build
    respond_with resource
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    if resource.user_instruments.empty?
      self.resource.user_instruments.build
    end
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource.user_instruments = []
    resource_updated = resource.update_without_password(account_update_params)
    yield resource if block_given?
    if resource_updated
      # if is_flashing_format?
      #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
      #     :update_needs_confirmation : :updated
      #   set_flash_message :notice, flash_key
      # end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :firstname,
      :surname,
      :description,
      :avatar,
      :user_instruments_attributes => [:instrument_id, :genre_id]
    ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :firstname,
      :surname,
      :description,
      :avatar,
      :user_instruments_attributes => [:instrument_id, :genre_id]
    ])
  end

  protected

  def sign_up_params
    user_params = super
    user_params.merge(account: current_account)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    home_url(subdomain: resource.account.subdomain)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
