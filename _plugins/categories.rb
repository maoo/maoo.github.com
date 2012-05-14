module Jekyll

  class CategoryIndex < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['category'] = site.categories[category]
      self.data['title'] = "#{category}"
    end
  end

  class CategoriesCloud < Page
    def initialize(site, base, categories)
      @site = site
      @base = base
      @categories = categories
      @name = 'index.html'
      @dir = 'category'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'categories.html')
      self.data['categories'] = categories;
    end
  end

  class CategoryGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'category'
        dir = site.config['category_dir'] || 'category'
        site.categories.keys.each do |category|
          write_category_index(site, File.join(dir, category), category)
        end
      end
    end
  
    def write_category_index(site, dir, category)
      index = CategoryIndex.new(site, site.source, dir, category)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

  class CategoriesGenerator < Generator
    safe true

    def generate(site)
      cats = Array.new
      site.categories.keys.each do |category|
        c = Hash["title" => category,
                 "size" => 20 + 3*site.categories[category].length]
        cats.push(c)
      end
      write_categories_cloud(site, cats)
    end

    def write_categories_cloud(site, categories)
      cloud = CategoriesCloud.new(site, site.source, categories)
      cloud.render(site.layouts, site.site_payload)
      cloud.write(site.dest)
      site.pages << cloud
    end
  end

end
