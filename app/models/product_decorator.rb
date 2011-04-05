Product.class_eval do
  has_many :product_taxons
  has_many :taxons, :through=>:product_taxons

  #default_scope :include=>:product_taxons, :order=>"product_taxons.position"
  scope :ordered, {:include=>:product_taxons, :order=>"product_taxons.position"}

  scope :available, lambda { |*args| 
      { :conditions => ["products.available_on <= ?", args.first || Time.zone.now], 
        :order => 'product_taxons.position',
        :include=>:product_taxons
      } 
  } 

  def in_taxon?(taxon)
    case taxon
      when String
        self.taxons.map{|t| [t.name.downcase,t.permalink.downcase]}.flatten.include?(taxon.strip.downcase)
      when Integer
        self.taxons.map{|t| t.id}.include?(taxon)
      when Taxon
        self.taxons.include?(taxon)
      else
        false
    end
  end

end
