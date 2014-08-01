task :update_views => :environment do
	videos = Video.all.order(updated_at: :asc).limit(50)

	videos.each do |video|
		video.save
	end
end