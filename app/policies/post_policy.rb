class PostPolicy < ApplicationPolicy

  # def permitted_attributes
  #   if user.admin? || user.owner_of?(post)
  #     [:title, :body, :tag_list]
  #   else
  #     [:tag_list]
  #   end
  # end
  def index?
    true
  end

  def show?
    if ( user.admin? || user.moderator? )
      true
    else
      false
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if !user.present?
        scope.none
      elsif (user.admin? || user.moderator?)
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
