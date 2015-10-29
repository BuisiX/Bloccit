class PostPolicy < ApplicationPolicy

  def permitted_attributes
    if user.admin? || user.owner_of?(post)
      [:title, :body, :tag_list]
    else
      [:tag_list]
    end
  end

  class Scope
    attr_reader :user, :posts, :scope

    def initialize(user, posts)
      @user = user
      @posts = posts
    end

    def resolve
      if user.present? && (record.user == user || user.admin? || user.moderator?)
        scope.all
      else
        scope.where :published => true
      end
    end
  end
end
