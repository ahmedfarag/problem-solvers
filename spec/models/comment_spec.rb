require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

