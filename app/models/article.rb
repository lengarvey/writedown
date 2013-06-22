class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize(params = {})
    self.markdown = params[:markdown] if params[:markdown]
  end

  def persisted?
    false
  end

  attr_reader :markdown

  def markdown=(markdown)
    @markdown = markdown
    @html = convert_to_html
  end

  def html
    if @html.blank?
      "<p>Start typing in white space on the left</p>"
    else
      @html
    end
  end

  private

  def convert_to_html
    html = MarkdownService.new.render_to_html(@markdown)
    Rails.logger.info "--------"
    Rails.logger.info html
    Rails.logger.info "--------"
    html
  end

end
