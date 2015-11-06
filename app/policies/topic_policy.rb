class TopicPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.admin?
  end

  def update?
    user.present? && user.admin
  end
end
