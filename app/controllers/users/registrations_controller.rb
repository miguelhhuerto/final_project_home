class Users::RegistrationsController < Devise::RegistrationsController
  def new
    if params[:promoter].present?
      cookies[:promoter] = params[:promoter]
    end
    super
  end

  def create
    super do |user|
      promoter_email = cookies[:promoter]
      if promoter_email.present?
        promoter = User.find_by(email: promoter_email)
        if promoter
          user.update(parent_id: promoter.id)
          promoter.increment!(:children_members, 1)
        end
        cookies.delete(:promoter)
      end

      if params[:promoter]
        promoter = User.find_by(email: params[:promoter])
        user.parent = promoter if promoter
      end
    end
  end
end