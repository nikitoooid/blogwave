require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :title }

  it { should have_one_attached :cover_image }
  it { should have_rich_text :content }
end
