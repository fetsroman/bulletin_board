require 'rails_helper'

RSpec.describe Comment, type: :model do
    let(:user) { create(:user) }
    let(:advert) { create(:advert, user: user) }
    let(:comment) { create(:comment, user: user, advert: advert) }

  it "is valid params" do
    expect(comment).to be_valid
  end

  it "is invalid without content" do
    comment = Comment.new(content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank")
  end
end
