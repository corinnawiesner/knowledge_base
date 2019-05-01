With the knowledge base you can manage articles. An article has a title, an abstract and contains at least one or multiple questions. Questions also have a title, an abstract and an answer. Each article and question will be translated from English to German on creation or editing.

The knowledge base was built with Ruby 2.5.3 and Rails 5.2. It uses Postgres as the database and Redis for translation background jobs. Texts are translated with Amazon Translate.

On the start page you will see an overview of the articles paginated by 10 articles on each page. To create an article click on the "Create a new article" link in the content, fill out the form and save it. After saving you will be on the article page where you can manage (create, edit, delete) the article's questions. The questions are also paginated by 10 questions on each page.
You can also find a quick access to the article creation on the right side of the menu with the "Create a new article" link.
