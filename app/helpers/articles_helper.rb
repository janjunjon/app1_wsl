module ArticlesHelper
    def search_articles
        if params[:degree] && !params[:keyword].present? && !params[:year].present?
			@articles = Article.where(degree: params[:degree]).paginate(page: params[:page], per_page: 10)
		elsif !params[:degree].present? && params[:keyword] && !params[:year].present?
			@articles = Article.where("title like ? OR abstract like ? OR author like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").paginate(page: params[:page], per_page: 10)
		elsif !params[:degree].present? && !params[:keyword].present? && params[:year]
			@articles = Article.where(year: params[:year]).paginate(page: params[:page], per_page: 10)
		elsif params[:degree] && params[:keyword] && !params[:year].present?
            @articles = Article.where("title like ? OR abstract like ? OR author like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree]).paginate(page: params[:page], per_page: 10)
		elsif !params[:degree].present? && params[:keyword] && params[:year]
			@articles = Article.where("title like ? OR abstract like ? OR author like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif params[:degree] && !params[:keyword].present? && params[:year]
            @articles = Article.where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
		elsif params[:degree] && params[:keyword] && params[:year] 
            @articles = Article.where("title like ? OR abstract like ? OR author like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
        end
    end

    def is_params_empty?
        # params[:degree] == "" && params[:keyword] == "" && params[:year] == ""
        # !params.has_key?(:degree) && params.has_key?(:keyword) && params.has_key?(:year)
        !params[:degree] && !params[:keyword] && !params[:year]
    end
end
