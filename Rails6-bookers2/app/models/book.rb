class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(word, search)
    if search == 'perfect'
      Book.where(title: word).or(Book.where(body: word))

    elsif search == 'forward'
      Book.where('title LIKE ?', word + '%').or(Book.where('body LIKE ?', word + '%'))

    elsif search == 'backward'
      Book.where('title LIKE ?', '%' + word).or(Book.where('body LIKE ?', '%' + word))

    elsif search == 'partial'
      Book.where('title LIKE ?', '%' + word + '%').or(Book.where('body LIKE ?', '%' + word + '%'))

    else
      Book.all

    end
  end
end