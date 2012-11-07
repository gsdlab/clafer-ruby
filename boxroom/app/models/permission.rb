class Permission < ActiveRecord::Base
  belongs_to :group
  belongs_to :folder

  attr_accessible :can_create, :can_read, :can_update, :can_delete

  include Clafer
  clafer_model true do
    subclafers :can_create, :can_read, :can_update, :can_delete
  end
end
