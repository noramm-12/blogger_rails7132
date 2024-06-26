class MoveDescriptionToActionText < ActiveRecord::Migration[7.1]
  def change
    Article.all.find_each do |article|
      article.update(content: article.description) if article.description.present?
    end

    remove_column :articles ,:description
  end
end
