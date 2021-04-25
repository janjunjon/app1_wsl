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
		filename = dir + "#{@article.romaji_name}_#{@article.year}.pdf"
		s3 = Aws::S3::Client.new(
			:region => 'ap-northeast-1',
			:access_key_id => Rails.application.credentials.aws[:access_key_id],
			:secret_access_key => Rails.application.credentials.aws[:secret_access_key]
		)
		@bucket = s3.list_buckets.buckets[1]
		@objects = s3.list_objects_v2(
			bucket: @bucket.name
		).contents
		@paper = s3.get_object(
			bucket: @bucket.name,
			key: filename
		).body
		send_data @paper.read, filename: filename, disposition: 'attachment', type: 'pdf'
	end
end
