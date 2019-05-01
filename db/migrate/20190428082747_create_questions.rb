class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :article_id
      t.date :published_at

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Question.create_translation_table!(
          title: :string,
          abstract: :text,
          answer: :text
        )
      end

      dir.down do
        Question.drop_translation_table!
      end
    end
  end
end
