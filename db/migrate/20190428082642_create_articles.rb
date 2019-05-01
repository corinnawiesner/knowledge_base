class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Article.create_translation_table!(
          title: :string,
          abstract: :text
        )
      end

      dir.down do
        Article.drop_translation_table!
      end
    end
  end
end
