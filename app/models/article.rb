class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize(params)
    self.markdown = params[:markdown]
  end

  def persisted?
    false
  end

  attr_reader :markdown, :html

  def markdown=(markdown)
    @markdown = markdown
    @html = convert_to_html
  end

  def html
    @html.try(:html_safe)
  end

  private

  def convert_to_html
    MarkdownService.new.render_to_html(@markdown)
  end

end
