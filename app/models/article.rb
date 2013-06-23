class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize(params = {})
    @name = Time.now.to_i
    self.markdown = params[:markdown] if params[:markdown]
    @name = params[:name] if params[:name]
  end

  def persisted?
    false
  end

  attr_reader :markdown, :html, :name

  def markdown=(markdown)
    @markdown = markdown
    @html = convert_to_html
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
