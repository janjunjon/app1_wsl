class ArticlesController < ApplicationController
	require 'aws-sdk-s3'
	include ArticlesHelper
	before_action :is_lagis?
	before_action :logged_in_user, only: :show

	def index
		@articles = Article.all.paginate(page: params[:page], per_page: 10)
	end

	def search
		search_articles
	end

	def show
		@article = Article.find_by(id: params[:id])
	end

	def download
		@article = Article.find_by(id: params[:id])
		dir = "articles/"
		filename = dir + "Juntaro ISHIHARA_2020.pdf"
		s3 = Aws::S3::Client.new(
			:region => 'ap-northeast-1',
			:access_key_id => 'AKIAX37AW7MND57NGIW2',
			:secret_access_key => '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'
		)
		# bucket = s3.buckets['www.lagis.index']
		@bucket = s3.list_buckets.buckets[1]
		@objects = s3.list_objects_v2(
			bucket: @bucket.name,
			max_keys: 10
		).contents
		@paper = s3.get_object(
			bucket: @bucket.name,
			key: filename
		).body
		send_data @paper.read, filename: filename, disposition: 'attachment', type: 'pdf'
		redirect_to @article
	end
end
