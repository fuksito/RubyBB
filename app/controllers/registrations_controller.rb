class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    name_changed = @user.name != params[:user][:name]
    password_changed = !params[:user][:password].empty?
    return super if email_changed || name_changed || password_changed
    params[:user].delete :current_password

    respond_to do |format|
      if @user.update_without_password(params[:user])
        format.html { redirect_to user_url(@user) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end 
