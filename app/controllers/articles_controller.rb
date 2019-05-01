class ArticlesController < ApplicationController
  before_action :load_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.
      eager_load(:questions).
      with_translations(I18n.locale).
      order(created_at: :asc).
      page(params[:page]).
      per(10)
  end

  # GET /articles/1
  def show
    @questions = @article.
      questions.
      order(created_at: :asc).
      page(params[:page]).
      per(10)
  end

  # GET /articles/new
  def new
    @article_form = Articles::NewForm.new
  end

  # POST /articles/
  def create
    @article_form = Articles::NewForm.new(new_article_params)

    respond_to do |format|
      if @article_form.save
        format.html { redirect_to @article_form.article, success: t("articles.create.success") }
      else
        format.html do
          flash.now[:error] = t("articles.create.error")
          render :new
        end
      end
    end
  end

  # GET /articles/1/edit
  def edit
    @article_form = Articles::EditForm.new(article: @article)
  end

  # PUT /articles/1
  def update
    @article_form = Articles::EditForm.new(edit_article_params.merge(article: @article))

    respond_to do |format|
      if @article_form.save
        format.html { redirect_to @article, success: t("articles.update.success") }
      else
        format.html do
          flash.now[:error] = t("articles.update.error")
          render :edit
        end
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, success: t("articles.destroy.success") }
    end
  end

  private

    def load_article
      @article = Article.where(id: params[:id]).first
      raise ActiveRecord::RecordNotFound if @article.blank?
    end

    def new_article_params
      params.require(:article).permit(
        :title,
        :abstract,
        :question_title,
        :question_abstract,
        :question_answer,
      )
    end

    def edit_article_params
      params.require(:article).permit(
        :title,
        :abstract,
      )
    end
end
