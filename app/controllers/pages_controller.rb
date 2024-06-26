# This is the PagesController class.
class PagesController < StoreController

  def matesclubform
    @products = Spree::Product.all

  end
end
