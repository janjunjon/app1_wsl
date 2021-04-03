module ArticlesHelper
    def search_articles
        if !params[:degree].nil? && !params[:keyword].nil? && !params[:year].nil?
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif !params[:degree].nil? && !params[:keyword].nil?
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree]).paginate(page: params[:page], per_page: 10)
        elsif !params[:keyword].nil? && !params[:year].nil?
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif !params[:degree].nil? && !params[:year].nil?
            @articles = Article.where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif !params[:degree].nil?
            @articles = Article.where(degree: params[:degree]).paginate(page: params[:page], per_page: 10)
        elsif !params[:year].nil?
            @articles = Article.where(year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif !params[:keyword].nil?
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").paginate(page: params[:page], per_page: 10)
        end
    end
end
