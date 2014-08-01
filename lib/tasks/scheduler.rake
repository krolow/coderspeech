require 'sitemap_generator'

task :update_views => :environment do
	videos = Video.all.order(updated_at: :asc).limit(50)

	videos.each do |video|
		video.save
	end
end

task :generate_sitemap => :environment do
	SitemapGenerator::Sitemap.default_host = 'http://www.coderspeech.com'
	# pick a place safe to write the files
	SitemapGenerator::Sitemap.public_path = 'tmp/'
	# store on S3 using Fog
	SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
	# inform the map cross-linking where to find the other maps
	SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/"
	# pick a namespace within your bucket to organize your maps
	SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'	
	SitemapGenerator::Sitemap.create do
	  categories = Category.all.order(name: :asc)
	  categories.each do |category|
	  	add video_category_path(category), changefreq: 'daily', priority: '0.9'
	  end
	  videos = Video.all.published.includes(:category).order(created_at: :asc)
	  videos.each do |video|
	  	add video_show_path(video.category, video),
	  		lastmod: video.updated_at,
	  		video: {
	  			thumbnail_loc: video.image.url(:medium),
	  			title: video.title,
	  			description: video.short_description,
	  			player_loc: video.embed_url,
	  			view_count: video.views,
	  			tags: video.tags,
	  			category: video.category.name
	  		}
	  end
	end
end