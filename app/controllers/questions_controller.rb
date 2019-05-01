class QuestionsController < ApplicationController
  before_action :load_article, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  # GET /articles/1/questions/1
  def show
  end

  # GET /articles/1/questions/new
  def new
    @question_form = Questions::NewForm.new(article: @article)
  end

  # POST /articles/1/questions/
  def create
    @question_form = Questions::NewForm.new(question_params.merge(article: @article))

    respond_to do |format|
      if @question_form.save
        format.html { redirect_to article_url(@question_form.article), success: t("questions.create.success") }
      else
        format.html do
          flash.now[:error] = t("questions.create.error")
          render :new
        end
      end
    end
  end

  # GET /articles/1/questions/1/edit
  def edit
    @question_form = Questions::EditForm.new(question: @question)
  end

  # PUT /articles/1/questions/1
  def update
    @question_form = Questions::EditForm.new(question_params.merge(question: @question))

    respond_to do |format|
      if @question_form.save
        format.html { redirect_to article_url(@article), success: t("questions.update.success") }
      else
        format.html do
          flash.now[:error] = t("questions.update.error")
          render :edit
        end
      end
    end
  end

  # DELETE /articles/1/questions/1
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to article_url(@article), success: t("questions.destroy.success") }
    end
  end

  private

    def load_article
      @article = Article.where(id: params[:article_id]).first
      raise ActiveRecord::RecordNotFound if @article.blank?
    end

    def load_question
      @question = Question.where(article_id: params[:article_id], id: params[:id]).first
      raise ActiveRecord::RecordNotFound if @question.blank?
    end

    def question_params
      params.require(:question).permit(
        :title,
        :abstract,
        :answer,
      )
    end
end
