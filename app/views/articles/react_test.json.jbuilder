
json.articles @articles do |article|
    json.id article.id
    json.title article.title
    json.author article.author
    json.year article.year
    json.degree article.degree
    json.abstract article.abstract
end