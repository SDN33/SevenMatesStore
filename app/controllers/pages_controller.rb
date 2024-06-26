# This is the PagesController class.
class PagesController < StoreController

  def matesclubform
    @products = Spree::Product.all
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

  def contact
  end
end
